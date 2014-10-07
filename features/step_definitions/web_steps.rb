def table_matches_for(needle)
  table_matches = []
  if page.has_css? "table"
    shortened = needle.gsub(" ","")
    table_matches = page.all('table').map do |table|
      table.text
    end.select do |table|
      table.include? shortened
    end
  end
  table_matches
end

Then(/^(?:|I )should see "([^"]*?)"$/) do |text|
  table_matches_for(text).any? or (expect(page.text).to include text)
end

Then(/^(?:|I )should not see "([^"]*?)"$/) do |text|
  expect(table_matches_for(text)).to be_empty
  expect(page.text).to_not include text
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
