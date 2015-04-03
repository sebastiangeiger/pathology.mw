Given(/^the specimen "(.*?)" exists$/) do |description|
  FactoryGirl.create(:specimen, description: description)
end

Given(/^I have create the following specimen for "(.*?)":$/) do |patient_name, table|
    step %{I go to the patient page for "#{patient_name}"}
    step %{I click on "Add specimen"}
    table.raw.each do |field_name,value|
      RobustFillIn.new(page).fill_in(field_name,value)
    end
    step %{I click on "Save"}
end
