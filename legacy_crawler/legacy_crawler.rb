require 'fileutils'
require 'mechanize'
require 'yaml'
require 'forwardable'
require 'pry'
require 'pp'

class SignedInMechanize
  def initialize(agent, configuration)
    @agent, @configuration = agent, configuration
    @signed_in = false
  end
  def get(url)
    sign_in unless @signed_in
    return agent.get(url)
  end

  def sign_in
    if @signed_in
      puts "Already Signed in"
    else
      page = agent.get(@configuration[:base_url])
      login_form = page.form_with(class: "login_form")
      login_form.username = @configuration[:username]
      login_form.password = @configuration[:password]
      page = agent.submit(login_form, login_form.buttons.first)
      @signed_in = true
      puts "Signed in"
    end
  end

  private
  def agent; @agent; end
end

class DataRepository

  def initialize(file_path)
    @file_path = file_path
    if File.exists? file_path
      @data = YAML.load_file(file_path)
    else
      @data = {}
    end
  end

  def add(keys, new_data)
    element = @data
    while key = keys.shift do
      if keys.empty?
        if new_data.is_a? Array
          element[key] ||= []
          element[key] += new_data
        elsif new_data.is_a? Hash
          element[key] = new_data
        else
          raise
        end
      else
        element[key] ||= {}
      end
      element = element[key]
    end
  end

  def get(key)
    @data[key]
  end

  def to_s
    @data
  end

  def save!
    backup!
    File.open(@file_path, "w+") do |file|
      file.write(YAML.dump(@data))
    end
  end

  def backup!
    if File.exists? @file_path
      extension = File.extname(@file_path)
      basename = File.basename(@file_path, extension)
      new_name = basename + "." + Time.now.to_s + extension
      new_path = File.join(File.dirname(@file_path), new_name)
      FileUtils.cp @file_path, new_path
    end
  end

end

class PatientFinder

  def initialize(configuration, data_repository)
    @configuration = configuration
    @agent = SignedInMechanize.new(Mechanize.new, @configuration)
    @data_repository = data_repository
  end

  def get_all_patient_links
    page = agent.get(@configuration[:base_url] + "/patients")
    while true
      @data_repository.add(:patient_links, patient_links_from(page))
      if next_page_link = page.link_with(text: ">")
        page = next_page_link.click
        puts %Q{Now on "#{page.uri.to_s}"}
      else
        break
      end
    end
  end

  def patient_links_from(page)
    page.links_with(text: /^\s*PHTRS\s+\d+$/).
      map(&:uri).map(&:to_s)
  end

  def get_all_patients
    patient_links = @data_repository.get(:patient_links)#.first(1)
    patients = patient_links.each_with_index do |patient_link,i|
      puts "Patient Detail #{i+1}/#{patient_links.size}"
      patient = get_patient_detail(patient_link)
      @data_repository.add([:patients, patient[:id]], patient)
    end
  end

  def get_patient_detail(patient_link)
    result = {patient_link: patient_link,
              id: patient_link.split("/").last.to_i}
    page = agent.get(patient_link)
    patient_info_table = page.search('table').first
    patient_info_table.search("tr").each do |row|
      key = row.search("th").first.text.gsub(" ","_").downcase.to_sym
      value = row.search("td").first.text
      result[key] = value
    end
    raise unless result[:id] == (result[:patient_number].match(/^\s*PHRS\s+(\d+)/)[1].to_i)
    edit_link = result[:patient_link].gsub(/\/patient\//, "/edit/")
    page = agent.get(edit_link)
    form = page.forms.first
    result[:first_name] = form.field_with(name: "firstname").value
    result[:last_name] = form.field_with(name: "lastname").value
    result
  end

  def run
    get_all_patients
  end

  private
  def agent
    @agent
  end
end

# vvvvv Workspace vvvv
data_repository = DataRepository.new('data.yml')
configuration = YAML.load_file('config.yml')
# 1. PatientFinder.new(configuration, data_repository).get_all_patient_links
# 2.  PatientFinder.new(configuration, data_repository).get_all_patients
# data_repository.save!
