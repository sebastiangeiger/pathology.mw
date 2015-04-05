Given(/^there are no users$/) do
  expect(User.count).to eql 0
end

Then(/^there should be (\d+) user$/) do |number_of_users|
  expect(User.count).to eql (number_of_users.to_i)
end

Given(/^(?:|I )sign(?:|ed) up with "(.*?)" \/ "(.*?)"$/) do |email, password|
  expect(User.count).to eql 0
  step %(go to the sign up page)
  step %(fill "Email" with "#{email}")
  step %(fill "Password" with "#{password}")
  step %(fill "Password confirmation" with "#{password}")
  step %(click on "Sign up")
  expect(User.count).to eql 1
end

When(/^(?:|I )sign in with "(.*?)" \/ "(.*?)"$/) do |email, password|
  step %(go to the sign in page)
  step %(fill "Email" with "#{email}")
  step %(fill "Password" with "#{password}")
  step %(click on "Sign in")
  step %(should see "Signed in successfully")
end

Given(/^the user "(.*?)" \/ "(.*?)" exists$/) do |email, password|
  User.create(email: email, password: password).confirm!
end

Given(/^the (administrator|guest|pathologist) "(.*?)" \/ "(.*?)" exists$/) do |role_name, email, password|
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

Given(/^I am signed in as an? (administrator|pathologist)$/) do |role_name|
  step %(the #{role_name} "#{role_name}@example.com" / "supersecret" exists)
  step %(sign in with "#{role_name}@example.com" / "supersecret")
end
