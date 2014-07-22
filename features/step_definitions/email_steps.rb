When(/^I click on the confirmation link in the email for "(.*?)"$/) do |email_address|
  email = ActionMailer::Base.deliveries.select do |email|
    email.to.include?(email_address)
  end.first
  expect(email).to be_present
  email_content = email.body.raw_source
  email_content = Nokogiri::HTML.parse(email_content);
  confirmation_link = email_content.
    css('a').
    select {|link| link.text.include? "Confirm my account"}.
    first
  expect(confirmation_link).to be_present
  visit confirmation_link['href']
end
