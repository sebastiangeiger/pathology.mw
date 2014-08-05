require 'mechanize'
require 'yaml'
require 'forwardable'
require 'pry'


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
  def add(key, new_data)
    @data[key] ||= []
    @data[key] += Array(new_data)
  end
  def to_s
    @data.inspect
  end
  def save!
    File.open(@file_path, "w+") do |file|
      file.write(YAML.dump(@data))
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

  def run
    get_all_patients
  end

  private
  def agent
    @agent
  end
end

data_repository = DataRepository.new('data.yml')
configuration = YAML.load_file('config.yml')
PatientFinder.new(configuration, data_repository).get_all_patient_links
data_repository.save!
puts data_repository
