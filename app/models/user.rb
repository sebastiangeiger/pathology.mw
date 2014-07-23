class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  after_initialize :default_values
  validate :role_name_must_be_one_of_the_predefined_ones

  POSSIBLE_ROLE_NAMES = [:guest, :administrator, :pathologist, :physician]

  def role_name
    read_attribute(:role_name).downcase.to_sym
  end

  POSSIBLE_ROLE_NAMES.each do |name|
    question = (name.to_s+"?").to_sym
    define_method(question) { return role_name == name }
  end
  alias_method :admin?, :administrator?

  def self.possible_role_names
    POSSIBLE_ROLE_NAMES.map(&:to_s).map(&:capitalize)
  end

  private
  def default_values
    self.role_name ||= :guest
  end

  def role_name_must_be_one_of_the_predefined_ones
    unless POSSIBLE_ROLE_NAMES.include?(role_name)
      message = "Role name must be one of: #{POSSIBLE_ROLE_NAMES.join(", ")}"
      errors.add(:role_name, message)
    end
  end
end
