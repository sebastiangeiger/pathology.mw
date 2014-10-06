class RobustFillIn
  def initialize(page)
    @page = page
    @debug = false
  end
  def fill_in(field_name,value)
    @field_name = field_name
    @value = value
    try_all(:date_input_field,:input_field, :disabled_input_field,
            :fake_input_field, :radio_buttons,:select_field,:chosen_combobox,
            :checkbox_field)
  end
  def try_all(*methods)
    success = false
    until success or methods.empty? do
      method = methods.shift
      begin
        self.send(method)
        success = true
        debug "Filled out #{@field_name} with #{@value.inspect} using #{method}"
      rescue Exception => e
        debug "Failed to fill in #{@field_name} with #{@value.inspect} using #{method}: #{e.to_s}"
      end
    end
    raise %Q{Could not fill out "#{@field_name}" with "#{@value}"} unless success
  end

  def debug(message)
    puts message if @debug
  end

  def date_input_field
    field = @page.find_field(@field_name)
    raise unless field['type'] == "date"
    formatted_date = I18n.l(Date.parse(@value), format: '%Y-%m-%d')
    @page.fill_in @field_name, with: formatted_date
  end

  def input_field
    @page.fill_in @field_name, with: @value
  end

  def disabled_input_field
    #Filling out a disabled field is fine as long as the desired input is blank
    @page.field_labeled(@field_name, disabled: true)
    unless @value.blank?
      raise "Found disabled field #{@field_name} but your input was not blank"
    end
  end

  def fake_input_field
    id = @page.find('label', text: @field_name)['for']
    @page.find("input##{id}_fake_input").set(@value)
  end

  def radio_buttons
    label = @page.find('label', text: @field_name)
    start_of_id = label['for'] + "_"
    options_labels = @page.all("label[for^=#{start_of_id}]")
    fitting_labels = options_labels.select{|label| label.text == @value}
    raise unless fitting_labels.size == 1
    fitting_option_id = fitting_labels.first['for']
    @page.find("input[id=#{fitting_option_id}]").set(true)
  end

  def select_field
    @page.select @value, from: @field_name
  end

  def chosen_combobox
    raise unless value_field = @page.find_field(@field_name, visible:false)
    chosen_selector = "##{value_field['id']}_chosen.chosen-container"
    chosen_combobox = @page.find(chosen_selector)
    chosen_combobox.click
    chosen_combobox.native.send_keys(@value, :Down, :Enter)
    raise unless chosen_combobox.find('span').text == @value
  end

  def checkbox_field
    label = @page.find('label', text: @field_name)
    input = @page.find("input[id=#{label['for']}]")
    raise unless input['type'] == 'checkbox'
    input.set(@value == "true")
  end
end

When(/^(?:|I )fill "(.*?)" with "(.*?)"$/) do |field_name, value|
  RobustFillIn.new(page).fill_in(field_name,value)
end

When(/^I select "(.*?)" from the "(.*?)" dropdown$/) do |role_name, select_name|
  select role_name, from: select_name
end

When(/^I fill in the following:$/) do |table|
  table.raw.each do |field_name,value|
    RobustFillIn.new(page).fill_in(field_name,value)
  end
end

When(/^I enter "(.*?)" into "(.*?)"$/) do |value, field_name|
  RobustFillIn.new(page).fill_in(field_name,value)
end

Then(/^the value of the "(.*?)" input field should be "(.*?)"$/) do |field_name, value|
  label = page.find('label', text: field_name)
  input = page.find("input[id=#{label['for']}]")
  expect(input.value).to eql value
end

Then(/^I should see "(.*?)" in "(.*?)"$/) do |value, field_name|
  step %Q{the value of the "#{field_name}" input field should be "#{value}"}
end

Then(/^"(.*?)" should be empty$/) do |field_name|
  label = page.find('label', text: field_name)
  input = page.find("input[id=#{label['for']}]")
  expect(input.value).to be_blank
end
