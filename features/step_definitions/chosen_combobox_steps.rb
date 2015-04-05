When(/^I add the option "(.*?)" to the "(.*?)" combobox$/) do |value, field_name|
  chosen = chosen_fields_for(field_name)
  chosen.search_field.native.send_key(value)
  expect(chosen.result_list.text).to include %(Add option : "#{value}")
  chosen.search_field.native.send_key(:Down, :Enter)
  expect(chosen.selected_text_field.text).to eql value
end

When(/^I enter "(.*?)" into the "(.*?)" combobox and autocomplete the first entry$/) do |value, field_name|
  chosen = chosen_fields_for(field_name)
  chosen.search_field.native.send_key(value)
  expect(chosen.result_list.text).to_not include %(Add option : "#{value}")
  chosen.search_field.native.send_key(:Down, :Enter)
  expect(chosen.selected_text_field.text).to include value
end

Then(/^the entry "(.*?)" in the "(.*?)" combobox is shadowed by "(.*?)"$/) do |value, field_name, contender|
  chosen = chosen_fields_for(field_name)
  chosen.search_field.native.send_key(value)
  expect(chosen.result_list.text).to eql contender
end

When(/^I click on the fallback link for "(.*?)"$/) do |field_name|
  label = page.find('label', text: field_name)
  link = label.first(:xpath, ".//following-sibling::a[text()='Simple Input']")
  link.click
  expect(page.find_field(field_name)).to be_present
end

class ChosenWrapper
  def initialize(chosen_container)
    @chosen_container = chosen_container
  end

  def search_field
    @chosen_container.find('.chosen-search input')
  end

  def result_list
    @chosen_container.find('li')
  end

  def selected_text_field
    @chosen_container.find('span')
  end
end

def chosen_fields_for(field_name)
  input = page.find_field(field_name, visible: false)
  wrapper = input.find(:xpath, './/..') # aka. parent
  chosen_container = wrapper.find('.chosen-container')
  expect(chosen_container).to be_present
  chosen_container.click
  ChosenWrapper.new(chosen_container)
end
