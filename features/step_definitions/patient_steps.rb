require 'pry'

Then(/^I should see (\d+) patient in the table$/) do |row_count|
  expect(page.all('main table').size).to eql 1
  expect(page.all('main table tbody tr').size).to eql row_count.to_i
end

Given(/^the patient "(.*?)" exists$/) do |full_name|
  first_name, last_name = full_name.split(" ")
  FactoryGirl.create(:patient, first_name: first_name, last_name: last_name)
end


Given(/^there are no patients in the system$/) do
  expect(Patient.count).to eql 0
end

Then(/^there should be no patients in the system$/) do
  expect(Patient.count).to eql 0
end

Given(/^the patients (\d+) to (\d+) exist$/) do |from, to|
  (from.to_i .. to.to_i).each do |i|
    FactoryGirl.create(:patient, first_name: "Patient ##{i}", last_name: "Lastname")
  end
end

Given(/^the following patients exist:$/) do |table|
  table.hashes.each do |patient|
    first_name, last_name = patient["Name"].split(" ")
    FactoryGirl.create(:patient, first_name: first_name, last_name: last_name)
  end
end
