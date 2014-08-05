def get_file_path(args)
  raise "Usage: #{t}[FILE_PATH]" unless args[:file_path]
  file_path = File.absolute_path(args[:file_path])
  raise %Q{"#{file_path}" does not exist} unless File.exists?(file_path)
  file_path
end

def create_patients!(patients)
  patients.values.each {|patient| create_patient!(patient)}
end

def clean_up!(hash)
  hash.each_pair do |key, value|
    hash.delete(key) if value =~ /.*Not Set.*/
  end
end

def create_patient!(patient)
  raise unless "PHRS 00#{patient[:id]}" == patient[:patient_number]
  raise unless patient[:first_name] + " " + patient[:last_name] == patient[:name]
  patient.delete(:name)
  patient.delete(:patient_number)
  clean_up!(patient)
  if patient[:date_of_birth] and patient[:date_of_birth] != "0000-00-00"
    patient[:birthday] = patient[:date_of_birth]
  end
  patient.delete(:date_of_birth)
  if patient[:birthday].nil? and patient[:age].present?
    patient[:birthyear] = Date.today.year - patient[:age].to_i
  end
  patient.delete(:date_of_birth)
  birthday_unknown = patient[:birthday].nil? and patient[:birthyear].nil?
  raise if patient[:birthday].present? and patient[:birthyear].present?
  if record = Patient.where(id: patient[:id]).first
    unless record.first_name == patient[:first_name] and
      record.last_name == patient[:last_name]
      raise "Record already exists but names don't match (id: #{patient[:id]})"
    end
  else
    Patient.create!(id: patient[:id],
                    first_name: patient[:first_name],
                    last_name: patient[:last_name],
                    gender: patient[:gender],
                    birthday: patient[:birthday],
                    birthday_unknown: birthday_unknown,
                    birthyear: patient[:birthyear],
                    imported_on: Date.today,
                    legacy_link: patient[:patient_link])
  end
end

def create_specimens!(specimens)
  specimens.values.each {|specimen| create_specimen!(specimen)}
end

def create_specimen!(specimen)
  clean_up!(specimen)
  if specimen[:submitted_date] and specimen[:submitted_date] == "0000-00-00"
    specimen.delete(:submitted_date)
  end
  if specimen[:submitted_date].nil?
    matchdata = specimen[:path_number].match(/^(20\d{2})-/)
    if matchdata
      year = matchdata[1].to_i
      approximate_date = Date.new(year,1,1)
    else
      approximate_date = Date.today
    end
    specimen[:submitted_date] = approximate_date
  end
  if record = Specimen.where(id: specimen[:id]).first
    unless record.description == specimen[:specimentype] and
      record.patient_id == specimen[:patient_id]
      raise "Record already exists but names don't match (id: #{speciment[:id]})"
    end
  else
    Specimen.create!(id: specimen[:id],
                     patient_id: specimen[:patient_id],
                     description: specimen[:specimentype],
                     diagnosis: specimen[:diagnosistype],
                     pathology_number: specimen[:path_number],
                     notes: specimen[:notes],
                     date_submitted: specimen[:submitted_date],
                     imported_on: Date.today,
                     legacy_link: specimen[:specimen_link])
  end
end

def make_sure_all_specimen_are_there!(patients)
  patients.each do |id,patient|
    specimen_ids = patient[:specimen_links].map do |link|
      link.split("/").last.to_i
    end
    record = Patient.find(patient[:id])
    unless Set.new(record.specimens.map(&:id)) == Set.new(specimen_ids)
      raise "Patient ##{record.id} does not have all specimen"
    end
  end
end

def add_clinical_histories_to_specimen!(patients)
  patients.each do |id,patient|
    clinical_history = patient[:clinical_history]
    unless clinical_history == "# Not Set"
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
  desc "This imports the data from a data.yml file"
  task :import_from_data_yml, [:file_path] => [:environment] do |t,args|
    file_path = get_file_path(args)
    data = YAML.load_file(file_path)
    create_patients!(data[:patients])
    create_specimens!(data[:specimen])
    make_sure_all_specimen_are_there!(data[:patients])
    add_clinical_histories_to_specimen!(data[:patients])
  end

end
