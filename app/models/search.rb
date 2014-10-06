class Search
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_writer :maximum_age, :minimum_age

  def initialize(attributes = {})
    attributes ||= {}
    @executable = attributes.any?
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def is_executable?
    @executable
  end

  def execute
    Patient.maximum_age(maximum_age).all
  end

  def maximum_age
    Integer(@maximum_age) rescue nil
  end

  def minimum_age
    Integer(@minimum_age) rescue nil
  end
end
