Then(/^I should see (\d+) patient in the table$/) do |row_count|
  expect(page.all('main table').size).to eql 1
  expect(page.all('main table tbody tr').size).to eql row_count.to_i
end
