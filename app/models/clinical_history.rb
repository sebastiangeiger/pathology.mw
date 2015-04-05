class ClinicalHistory < ActiveRecord::Base
  has_many :specimens
  validates :date, presence: true

  def date_submitted
    date
  end
end
