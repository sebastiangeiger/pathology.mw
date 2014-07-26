class PatientTable
  # Configuration
  def desired_columns
    %i[patient_number first_name last_name gender age district]
  end
  # Functioniality
  def initialize(patients)
    @patients = patients
  end
  def headers
    desired_columns.map do |column|
      column.to_s.split("_").map(&:capitalize).join(" ")
    end
  end
  def rows
    @patients.map do |patient|
      cells = desired_columns.map do |column_name|
        patient.send(column_name)
      end
      link = Rails.application.routes.url_helpers.patient_path(patient)
      {cells: cells, link: link}
    end
  end
end
