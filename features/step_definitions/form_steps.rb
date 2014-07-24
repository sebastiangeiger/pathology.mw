class RobustFillIn
  def initialize(page)
    @page = page
  end
  def fill_in(field_name,value)
    @field_name = field_name
    @value = value
    try_all(:input_field,:radio_buttons,:select_field)
  end
  def try_all(*methods)
    success = false
    until success or methods.empty? do
      method = methods.shift
      begin
        self.send(method)
        success = true
        # puts "Filled out #{@field_name} with #{@value}"
        # puts @page.all("input").map(&:value).inspect
      rescue Exception => e
        # puts e
      end
    end
    raise %Q{Could not fill out "#{@field_name}" with "#{@value}"} unless success
  end

  def input_field
    @page.fill_in @field_name, with: @value
  end

  def radio_buttons
    label = @page.find('label', text: @field_name)
    start_of_id = label['for'] + "_"
    options_labels = @page.all("label[for^=#{start_of_id}]")
    fitting_labels = options_labels.select{|label| label.text == @value}
    raise unless fitting_labels.size == 1
    fitting_option_id = fitting_labels.first['for']
    @page.find("input[id=#{fitting_option_id}]").click
  end

  def select_field
    @page.select @value, from: @field_name
  end
end

When(/^(?:|I )fill "(.*?)" with "(.*?)"$/) do |field_name, value|
  fill_in field_name, with: value
end

When(/^I select "(.*?)" from the "(.*?)" dropdown$/) do |role_name, select_name|
  select role_name, from: select_name
end

When(/^I fill in the following:$/) do |table|
  table.raw.each do |field_name,value|
    RobustFillIn.new(page).fill_in(field_name,value)
  end
end

