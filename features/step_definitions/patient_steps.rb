require 'pry'

Then(/^I should see (\d+) patient in the table$/) do |row_count|
  expect(page.all('main table').size).to eql 1
  expect(page.all('main table tbody tr').size).to eql row_count.to_i
end

Given(/^the patient "(.*?)" exists$/) do |full_name|
  first_name, last_name = full_name.split(' ')
  FactoryGirl.create(:patient, first_name: first_name, last_name: last_name)
end

Given(/^there are no patients in the system$/) do
  expect(Patient.count).to eql 0
end

Then(/^there should be no patients in the system$/) do
  expect(Patient.count).to eql 0
end

Given(/^the patients (\d+) to (\d+) exist$/) do |from, to|
  (from.to_i..to.to_i).each do |i|
    FactoryGirl.create(:patient, first_name: "Patient ##{i}", last_name: 'Lastname')
  end
end

Given(/^the following patients exist:$/) do |table|
  table.hashes.each do |patient|
    PatientBuilder.new(patient).create!
  end
end

Given(/^I have created the following patient:$/) do |table|
  step %(I am on the patients overview page)
  step %(I click on "New Patient")
  table.raw.each do |field_name, value|
    RobustFillIn.new(page).fill_in(field_name, value)
  end
  step %(I click on "Create Patient")
end

class PatientBuilder
  def initialize(hash)
    @hash = hash
    @options = {}
    @option_processors = []
  end

  def read_options!
    @hash.each_pair do |attribute, value|
      begin
        send(attribute.parameterize.underscore.to_sym, value)
      rescue NoMethodError
        raise %(Don't know what to do with column "#{attribute}".)
      end
    end
  end

  def create!
    read_options!
    begin
      FactoryGirl.create(:patient, @options)
      rescue
        binding.pry
    end
  end

  def name(name)
    first_name, last_name = name.split(' ')
    @options.merge!(first_name: first_name, last_name: last_name)
  end

  def date_of_birth(date)
    @options.merge!(birthday: Date.parse(date), birthyear: nil)
  end

  def birthyear(year)
    @options.merge!(birthyear: Integer(year), birthday: nil)
  end

  def gender(gender)
    unless gender == 'unknown'
      @options.merge!(gender: gender)
    end
  end
end
