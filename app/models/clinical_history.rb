class ClinicalHistory < ActiveRecord::Base
  has_many :specimens
  validates :date, presence: true

  def date_submitted
    self.date
  end
end
