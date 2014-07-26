class Patient < ActiveRecord::Base
  validates :first_name, presence: true, length: { minimum: 1}
  validates :last_name,  presence: true, length: { minimum: 1}
  validates :gender, inclusion: ["Male","Female"]

  def patient_number
    "PHTRS #{format('%04d', id)}"
  end

  def full_name
    [first_name, last_name].join(" ")
  end

  def age
    now = Date.today
    year_adjustment = (now.month > birthday.month || (now.month == birthday.month && now.day >= birthday.day)) ? 0 : 1
    now.year - birthday.year - year_adjustment
  end

  def gender
    read_attribute(:gender).try(:capitalize)
  end

  alias_method :to_s, :full_name
end
