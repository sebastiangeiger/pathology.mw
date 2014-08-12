FactoryGirl.define do
  factory :patient do
    first_name 'Anne'
    last_name 'Moore'
    gender 'Female'
    birthday Date.parse("June 18 1990")
  end
end
