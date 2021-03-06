require 'open-uri'

def read_data(args)
  fail "Usage: #{t}[FILE_PATH_OR_URL]" unless args[:file_path_or_url]
  file_path_or_url = args[:file_path_or_url]
  if file_path_or_url =~ /^https?:\/\//
    YAML.load_file(open(file_path_or_url))
  else
    file_path = File.absolute_path(file_path_or_url)
    fail %("#{file_path}" does not exist) unless File.exist?(file_path)
    YAML.load_file(file_path)
  end
end

def create_patients!(patients)
  patients.values.each { |patient| create_patient!(patient) }
end

def clean_up!(hash)
  hash.each_pair do |key, value|
    hash.delete(key) if value =~ /.*Not Set.*/
  end
end

def create_patient!(patient)
  fail unless "PHRS 00#{patient[:id]}" == patient[:patient_number]
  fail unless patient[:first_name] + ' ' + patient[:last_name] == patient[:name]
  patient.delete(:name)
  patient.delete(:patient_number)
  clean_up!(patient)
  if patient[:date_of_birth] && patient[:date_of_birth] != '0000-00-00'
    patient[:birthday] = patient[:date_of_birth]
  end
  patient.delete(:date_of_birth)
  if patient[:birthday].nil? && patient[:age].present?
    patient[:birthyear] = Time.zone.today.year - patient[:age].to_i
  end
  patient.delete(:date_of_birth)
  birthday_unknown = (patient[:birthday].nil? && patient[:birthyear].nil?)
  fail if patient[:birthday].present? && patient[:birthyear].present?
  if record = Patient.where(id: patient[:id]).first
    unless record.first_name == patient[:first_name] &&
           record.last_name == patient[:last_name]
      fail "Record already exists but names don't match (id: #{patient[:id]})"
    end
  else
    Patient.create!(id: patient[:id],
                    first_name: patient[:first_name],
                    last_name: patient[:last_name],
                    gender: patient[:gender],
                    birthday: patient[:birthday],
                    birthday_unknown: birthday_unknown,
                    birthyear: patient[:birthyear],
                    imported_on: Time.zone.today,
                    legacy_link: patient[:patient_link])
  end
end

def create_specimens!(specimens)
  specimens.values.each { |specimen| create_specimen!(specimen) }
end

def create_specimen!(specimen)
  clean_up!(specimen)
  if specimen[:submitted_date] && specimen[:submitted_date] == '0000-00-00'
    specimen.delete(:submitted_date)
  end
  if specimen[:submitted_date].nil?
    matchdata = specimen[:path_number].match(/^(20\d{2})-/)
    if matchdata
      year = matchdata[1].to_i
      approximate_date = Date.new(year, 1, 1)
    else
      approximate_date = Time.zone.today
    end
    specimen[:submitted_date] = approximate_date
  end
  if record = Specimen.where(id: specimen[:id]).first
    unless record.description == specimen[:specimentype] &&
           record.patient_id == specimen[:patient_id]
      fail "Record already exists but names don't match (id: #{speciment[:id]})"
    end
  else
    Specimen.create!(id: specimen[:id],
                     patient_id: specimen[:patient_id],
                     description: specimen[:specimentype],
                     diagnosis: specimen[:diagnosistype],
                     pathology_number: specimen[:path_number],
                     notes: specimen[:notes],
                     date_submitted: specimen[:submitted_date],
                     imported_on: Time.zone.today,
                     legacy_link: specimen[:specimen_link])
  end
end

def make_sure_all_specimen_are_there!(patients)
  patients.each do |_id, patient|
    specimen_ids = patient[:specimen_links].map do |link|
      link.split('/').last.to_i
    end
    record = Patient.find(patient[:id])
    unless Set.new(record.specimens.map(&:id)) == Set.new(specimen_ids)
      fail "Patient ##{record.id} does not have all specimen"
    end
  end
end

def add_clinical_histories_to_specimen!(patients)
  patients.each do |_id, patient|
    clinical_history = patient[:clinical_history]
    unless clinical_history == '# Not Set'
      Specimen.where(patient_id: patient[:id]).each do |specimen|
        if specimen.clinical_history_description != clinical_history
          record = ClinicalHistory.create!(date: specimen.date_submitted,
                                           description: clinical_history)
          specimen.clinical_history = record
          specimen.save
        end
      end
    end
  end
end

namespace :legacy do
  desc 'This imports the data from a data.yml file'
  task :import_from_data_yml, [:file_path_or_url] => [:environment] do |_t, args|
    data = read_data(args)
    create_patients!(data[:patients])
    create_specimens!(data[:specimen])
    make_sure_all_specimen_are_there!(data[:patients])
    add_clinical_histories_to_specimen!(data[:patients])
  end
end
