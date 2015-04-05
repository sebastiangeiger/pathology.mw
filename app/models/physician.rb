class Physician < ActiveRecord::Base

  has_many :specimens

  def full_name
    "#{title} #{first_name} #{last_name}".strip
  end
end
