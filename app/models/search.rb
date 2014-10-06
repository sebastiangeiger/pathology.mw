class Search
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_writer :maximum_age, :minimum_age
  attr_accessor :gender, :name_query

  def initialize(attributes = {})
    attributes ||= {}
    attributes.select! { |k,v| v.present? }
    @fields = attributes.keys
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def is_executable?
    @fields.any?
  end

  def execute
    scopes.reduce(:merge).all
  end

  def scopes
    @fields.map do |field|
      Patient.send(field, self.send(field))
    end
  end

  def maximum_age
    Integer(@maximum_age) rescue nil
  end

  def minimum_age
    Integer(@minimum_age) rescue nil
  end
end
