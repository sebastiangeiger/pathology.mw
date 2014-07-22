Then(/^(?:|I )should see "(.*?)"$/) do |text|
  expect(page.text).to include text
end

Then(/^I should see "(.*?)" in the top bar$/) do |text|
  expect(page.find('.top-bar').text).to include text
end
