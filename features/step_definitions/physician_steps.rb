Given(/^the physician "(.*?)" exists$/) do |name|
  name, title, first_name, last_name = name.match(/(Dr\.) (\w+) (\w+)/).to_a
  FactoryGirl.create(:physician, first_name: first_name, last_name: last_name,
                                 title: title)
end
