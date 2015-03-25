def click_in_top_bar(*click_path)
  raise "More than two levels are currently not supported" unless click_path.size <= 2
  first_level, second_level = click_path
  top_bar = page.find(".top-bar")
  link = top_bar.find_link(first_level)
  if second_level
    dropdown = link.find(:xpath, "..").find("ul")
    link = dropdown.find_link(second_level);
  end
  link.click
end

When(/^(?:|I )go to the home page$/) do
  visit "/"
end

When(/^(?:|I )go to the sign in page$/) do
  visit "/users/sign_in"
end

When(/^(?:|I )go to the sign up page$/) do
  visit "/users/sign_up"
end

When(/^I go to the manage users page$/) do
  visit "/"
  click_in_top_bar "Manage", "Users"
end

Then(/^(?:|I )should(?:| still) be on the sign in page$/) do
  expect(current_path).to eql "/users/sign_in"
end

Then(/^I should be on the home page$/) do
  expect(current_path).to eql "/"
end

When(/^(?:I am on|go to) the patients overview page$/) do
  click_in_top_bar "Patients"
end

Then(/^I should be on the patients overview page$/) do
  expect(current_path).to eql "/patients"
end

When(/^I go to the patient page for "(.*?)"$/) do |patient_name|
  first_name, last_name = patient_name.split(" ")
  step %Q{go to the patients overview page}
  row = all('tr').select do |tr|
    tr.text.include?(first_name) and
      tr.text.include?(last_name)
  end.first
  if row and target = row['data-link-to']
    visit target
  else
    raise "Could not find link"
  end
end

When(/^I go to the patient edit page for "(.*?)"$/) do |patient_name|
  step %{I go to the patient page for "#{patient_name}"}
  step %{I click on "Edit Patient"}
end

Then(/^I should be on the patient page for "(.*?)"$/) do |full_name|
  first_name, last_name = full_name.split(" ")
  patient = Patient.find_by!(first_name: first_name, last_name: last_name)
  expect(current_path).to eql "/patients/#{patient.id}"
end
