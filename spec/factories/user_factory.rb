FactoryGirl.define do
  factory :user do
    email "user@email.com"
    password "supersecret"
    confirmation_token nil
    confirmed_at 1.hour.ago

    factory :admin do
      role_name :administrator
    end
    factory :administrator do
      role_name :administrator
    end
    factory :guest do
      role_name :guest
    end
    factory :pathologist do
      role_name :pathologist
    end
  end
end
