FactoryGirl.define do
  factory :specimen do
    patient
    clinical_history
    date_submitted 2.days.ago
  end
end

