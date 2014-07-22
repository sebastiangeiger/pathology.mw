When(/^(?:|I )go to the home page$/) do
  visit "/"
end

When(/^(?:|I )go to the sign in page$/) do
  visit "/users/sign_in"
end

When(/^(?:|I )go to the sign up page$/) do
  visit "/users/sign_up"
end

Then(/^(?:|I )should(?:| still) be on the sign in page$/) do
  expect(current_path).to eql "/users/sign_in"
end
