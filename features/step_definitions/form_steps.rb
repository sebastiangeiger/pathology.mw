When(/^(?:|I )fill "(.*?)" with "(.*?)"$/) do |field_name, value|
  fill_in field_name, with: value
end

When(/^I select "(.*?)" from the "(.*?)" dropdown$/) do |role_name, select_name|
  select role_name, from: select_name
end

