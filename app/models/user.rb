class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  POSSIBLE_ROLE_NAMES = [:guest, :administrator, :pathologist, :physician]
  validate :role_name_must_be_one_of_the_predefined_ones

  def role_name_must_be_one_of_the_predefined_ones
    unless POSSIBLE_ROLE_NAMES.include?(role_name)
      message = "Role name must be one of: #{POSSIBLE_ROLE_NAMES.join(", ")}"
      errors.add(:role_name, message)
    end
  end
end
