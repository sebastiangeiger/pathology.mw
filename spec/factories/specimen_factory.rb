FactoryGirl.define do
  factory :specimen do
    pathology_number "2014-QT-#{(1..9999).to_a.sample}"
    patient
    clinical_history
    date_submitted 2.days.ago
  end
end
