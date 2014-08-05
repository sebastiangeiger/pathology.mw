def get_file_path(args)
  raise "Usage: #{t}[FILE_PATH]" unless args[:file_path]
  file_path = File.absolute_path(args[:file_path])
  raise %Q{"#{file_path}" does not exist} unless File.exists?(file_path)
  file_path
end

def create_patients!(patients)
  patients.values.each {|patient| create_patient!(patient)}
end

def create_patient!(patient)
  raise unless "PHRS 00#{patient[:id]}" == patient[:patient_number]
  patient[:district] = nil if patient[:district] =~ /.*Not Set.*/
  if patient.delete(:date_of_birth) == "0000-00-00"
    patient[:birthday] = nil
  else
    patient[:birthday] = patient[:date_of_birth]
  end
  if patient[:birthday].nil? and patient[:age].present?
    patient[:birthyear] = Date.today.year - patient[:age].to_i
  end
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
                    birthyear: patient[:birthyear])
  end
end
namespace :legacy do
  desc "This imports the data from a data.yml file"
  task :import_from_data_yml, [:file_path] => [:environment] do |t,args|
    file_path = get_file_path(args)
    data = YAML.load_file(file_path)
    create_patients!(data[:patients])
  end

end
