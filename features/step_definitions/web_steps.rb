Then(/^(?:|I )should see "([^"]*?)"$/) do |text|
  expect(page.text).to include text
end

Then(/^(?:|I )should see "(.*?)" in the top bar$/) do |text|
  expect(page.find('.top-bar').text).to include text
end

Then(/^(?:|I )should see "(.*?)" within "(.*?)"$/) do |text, selector|
  selected_text = all(selector).map(&:text).join(" ")
  expect(selected_text).to include text
end

Then(/^(?:|I )should not see "(.*?)" within "(.*?)"$/) do |text, selector|
  selected_text = all(selector).map(&:text).join(" ")
  expect(selected_text).to_not include text
end

Then(/^I should see "(.*?)" in the headline$/) do |text|
  selected_text = all("h1").map(&:text).join(" ")
  expect(selected_text).to include text
end
