When(/^(?:|I )fill "(.*?)" with "(.*?)"$/) do |field_name, value|
  fill_in field_name, with: value
end

