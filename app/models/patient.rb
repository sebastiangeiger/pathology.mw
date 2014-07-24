class Patient < ActiveRecord::Base
  validates :first_name, presence: true, length: { minimum: 1}
  validates :last_name,  presence: true, length: { minimum: 1}

  def full_name
    [first_name, last_name].join(" ")
  end
end
