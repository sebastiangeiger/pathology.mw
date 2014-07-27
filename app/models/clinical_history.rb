class ClinicalHistory < ActiveRecord::Base
  belongs_to :patient
  validates :patient, presence: true
  validates :date, presence: true
end
