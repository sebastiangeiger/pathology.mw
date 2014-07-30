class ClinicalHistory < ActiveRecord::Base
  belongs_to :patient
  validates :patient, presence: true
  validates :description, presence: true
  validates :date, presence: true

  def date_submitted
    self.date
  end
end
