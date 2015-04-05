FactoryGirl.define do
  factory :physician do
    first_name 'John'
    last_name { |n| "D#{n}oe" }
    title 'Dr.'
  end
end
