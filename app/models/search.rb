class Search
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_writer :maximum_age, :minimum_age

  def initialize(attributes = [])
    attributes ||= []
    @executable = attributes.any?
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def is_executable?
    @executable
  end

  def execute
    Patient.where(maximum_birthday_conditions).all
  end

  def maximum_age
    @maximum_age.to_i if @maximum_age
  end

  def minimum_age
    @minimum_age.to_i if @minimum_age
  end

  private
  def maximum_birthday_conditions
    maximum_birthday = Date.today - maximum_age.years
    ['birthday > ? ', maximum_birthday]
  end
end
