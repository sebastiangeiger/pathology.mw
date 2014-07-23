Given(/^there are no users$/) do
  expect(User.count).to eql 0
end

Then(/^there should be (\d+) user$/) do |number_of_users|
  expect(User.count).to eql (number_of_users.to_i)
end

Given(/^(?:|I )signed up with "(.*?)" \/ "(.*?)"$/) do |email, password|
  expect(User.count).to eql 0
  step %Q{go to the sign up page}
  step %Q{fill "Email" with "#{email}"}
  step %Q{fill "Password" with "#{password}"}
  step %Q{fill "Password confirmation" with "#{password}"}
  step %Q{click on "Sign up"}
  expect(User.count).to eql 1
end

When(/^(?:|I )sign in with "(.*?)" \/ "(.*?)"$/) do |email, password|
  step %Q{go to the sign in page}
  step %Q{fill "Email" with "#{email}"}
  step %Q{fill "Password" with "#{password}"}
  step %Q{click on "Sign in"}
  step %Q{should see "Signed in successfully"}
end

Given(/^the user "(.*?)" \/ "(.*?)" exists$/) do |email, password|
  User.create(email: email, password: password).confirm!
end

Given(/^the (administrator|guest) "(.*?)" \/ "(.*?)" exists$/) do |role_name,email, password|
  role_name = role_name.to_sym
  User.create(email: email,
              password: password,
              role_name: role_name).confirm!
end

Then(/^"(.*?)" should be a physician$/) do |email|
  user = User.where(email: email).first
  expect(user).to be_present
  expect(user.role_name).to eql :physician
end

