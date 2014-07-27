FactoryGirl.define do
  factory :clinical_history do
    patient
    description "Some clincal history here"
    date 2.days.ago
  end
end

