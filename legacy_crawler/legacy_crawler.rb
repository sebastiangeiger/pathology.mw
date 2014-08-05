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
    keys = Array(keys)
    element = @data
    while key = keys.shift do
      if keys.empty?
        if new_data.is_a? Array
          element[key] ||= []
          element[key] += new_data
          element[key] = element[key].uniq
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

  def get_all_patients
    patient_links = @data_repository.get(:patient_links)
    patients = patient_links.each_with_index do |patient_link,i|
      puts "Patient Detail #{i+1}/#{patient_links.size}"
      patient = get_patient_detail(patient_link)
      @data_repository.add([:patients, patient[:id]], patient)
    end
  end

  private
  def patient_links_from(page)
    page.links_with(text: /^\s*PHTRS\s+\d+$/).
      map(&:uri).map(&:to_s)
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
    result[:specimen_links] = page.links_with(href: /\/patients\/edit_specimen\//).
      map(&:uri).map(&:to_s)
    raise unless result[:id] == (result[:patient_number].match(/^\s*phrs\s+(\d+)/)[1].to_i)
    edit_link = result[:patient_link].gsub(/\/patient\//, "/edit/")
    page = agent.get(edit_link)
    form = page.forms.first
    result[:first_name] = form.field_with(name: "firstname").value
    result[:last_name] = form.field_with(name: "lastname").value
    result
  end

  def agent
    @agent
  end
end

class SpecimenFinder
  def initialize(configuration, data_repository)
    @configuration = configuration
    @agent = SignedInMechanize.new(Mechanize.new, @configuration)
    @data_repository = data_repository
  end

  def get_all_specimen_links
    page = agent.get(@configuration[:base_url] + "/results")
    i = 0
    while true
      @data_repository.add(:specimen_links, specimen_links_from(page))
      if next_page_link = page.link_with(text: ">")
        page = next_page_link.click
        puts %Q{Now on "#{page.uri.to_s}"}
      else
        break
      end
    end
  end

  def get_all_specimen
    specimen_links = @data_repository.get(:specimen_links)#.first(1)
    specimen_links.each_with_index do |specimen_link,i|
      puts "Specimen Detail #{i+1}/#{specimen_links.size}"
      specimen = get_specimen_detail(specimen_link)
      @data_repository.add([:specimen, specimen[:id]], specimen)
    end
  end

  private
  def specimen_links_from(page)
    page.links_with(href: /\/patients\/edit_specimen\//).
      map(&:uri).map(&:to_s)
  end

  def get_specimen_detail(specimen_link)
    result = {id: specimen_link.split("/").last.to_i,
              patient_id: specimen_link.split("/")[-2].to_i}
    page = agent.get(specimen_link)
    specimen_form = page.forms.first
    specimen_form.fields.each do |field|
      key = field.name.to_sym
      if field.is_a? Mechanize::Form::Textarea or field.is_a? Mechanize::Form::Text
        value = field.value
      elsif field.is_a? Mechanize::Form::SelectList
        selected_options = field.options_with(value: field.value)
        raise "Failed at #{specimen_link}" if selected_options.empty?
        value = selected_options.first.text
      else
        raise "Failed at #{specimen_link}"
      end
      result[key] = value
    end
    result
  end

  def agent
    @agent
  end
end

class Experiments
  class << self
    def compare_specimen_links_from_results_and_patients(data_repository)
      patients = data_repository.get(:patients)
      specimen_links_from_results = data_repository.get(:specimen_links)
      specimen_links_from_patients = patients.values.map{|p| p[:specimen_links]}.flatten
      puts "Difference between the speciment links:"
      pp difference(specimen_links_from_patients, specimen_links_from_results)
    end
    def patients_with_several_specimen(data_repository)
      patients = data_repository.get(:patients)
      pp patients.select{|id,patient|
        patient[:specimen_links].size > 1
      }
    end
    private
    def difference(array_a, array_b)
      (array_a - array_b) | (array_b - array_a)
    end
  end
end

# vvvvv Workspace vvvv
data_repository = DataRepository.new('data.yml')
configuration = YAML.load_file('config.yml')
# 1. PatientFinder.new(configuration, data_repository).get_all_patient_links
# 2. PatientFinder.new(configuration, data_repository).get_all_patients
# 3. SpecimenFinder.new(configuration, data_repository).get_all_specimen_links
# 4.  SpecimenFinder.new(configuration, data_repository).get_all_specimen
# data_repository.save!
# Experiments.compare_specimen_links_from_results_and_patients(data_repository)
Experiments.patients_with_several_specimen(data_repository)
