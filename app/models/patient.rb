class Patient < ActiveRecord::Base
  attr_writer :birthday_unknown

  validates :first_name, presence: true, length: { minimum: 1}
  validates :last_name,  presence: true, length: { minimum: 1}
  validates :gender, inclusion: ["Male","Female"]
  validate :either_birthday_or_birthyear_must_be_set_or_birthday_unknown

  has_many :clinical_histories
  has_many :specimens

  def self.maximum_age(age = nil)
    if age
      maximum_birthday = Time.zone.today - age.years
      maximum_birthyear = Time.zone.today.year - age.to_i - 1
      self.where(['birthday >= ? OR birthyear >= ?', maximum_birthday, maximum_birthyear])
    else
      all
    end
  end

  def patient_number
    "PHTRS #{format('%04d', id)}"
  end

  def full_name
    [first_name, last_name].join(" ")
  end

  def age
    now = Time.zone.today
    if birthday
      year_adjustment = (now.month > birthday.month || (now.month == birthday.month && now.day >= birthday.day)) ? 0 : 1
      now.year - birthday.year - year_adjustment
    elsif birthyear
      now.year - birthyear
    else
      ""
    end
  end

  def detailed_age
    if birthday
      "#{age} (born #{I18n.l(birthday)})"
    elsif birthyear
      "#{age} (born in #{birthyear})"
    else
      ""
    end
  end

  def gender
    read_attribute(:gender).try(:capitalize)
  end

  def birthday_unknown
    @birthday_unknown != "0" and @birthday_unknown != 0 and @birthday_unknown
  end

  alias_method :to_s, :full_name

  def imported?
    imported_on.present?
  end

  private

  def either_birthday_or_birthyear_must_be_set_or_birthday_unknown
    unless birthday or birthyear or birthday_unknown
      errors.add(:birthday_birthyear_group, "Please select one of the three options:")
    end
  end

end
