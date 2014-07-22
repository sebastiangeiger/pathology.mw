Given(/^there are no users$/) do
  expect(User.count).to eql 0
end

When(/^I go to the home page$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I click on "(.*?)"$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

When(/^I fill "(.*?)" with "(.*?)"$/) do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

Then(/^there should be (\d+) user$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end
