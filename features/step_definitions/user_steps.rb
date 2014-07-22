Given(/^there are no users$/) do
  expect(User.count).to eql 0
end

Then(/^there should be (\d+) user$/) do |number_of_users|
  expect(User.count).to eql (number_of_users.to_i)
end
