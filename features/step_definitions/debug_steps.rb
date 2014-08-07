Then(/^debug$/) do
  require 'pry'
  binding.pry
end

Then(/^show me the page$/) do
  page.save_and_open_page
end
