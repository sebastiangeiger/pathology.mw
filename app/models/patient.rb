require 'pry'
class Patient < ActiveRecord::Base
  validates :first_name, presence: true, length: { minimum: 1}
  validates :last_name,  presence: true, length: { minimum: 1}
  validates :gender, inclusion: ["Male","Female"]
  validate :either_birthday_or_birthyear_must_be_set

  has_many :clinical_histories
  has_many :specimens

  def patient_number
    "PHTRS #{format('%04d', id)}"
  end

  def full_name
    [first_name, last_name].join(" ")
  end

  def age
    date = birthday || birthyear
    now = Date.today
    year_adjustment = (now.month > date.month || (now.month == date.month && now.day >= date.day)) ? 0 : 1
    now.year - date.year - year_adjustment
  end

  def detailed_age
    if birthday
      "#{age} (born #{I18n.l(birthday)})"
    elsif birthyear
      "#{age} (born in #{birthyear.year})"
    end
  end

  def gender
    read_attribute(:gender).try(:capitalize)
  end

  alias_method :to_s, :full_name

  private

  def either_birthday_or_birthyear_must_be_set
    unless birthday or birthyear
      errors.add(:birthday, "must be set")
    end
  end

end
