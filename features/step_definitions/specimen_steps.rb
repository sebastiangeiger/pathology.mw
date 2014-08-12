Given(/^the specimen "(.*?)" exists$/) do |description|
  FactoryGirl.create(:specimen, description: description)
end
