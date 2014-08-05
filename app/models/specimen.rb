class Specimen < ActiveRecord::Base
  belongs_to :patient
  belongs_to :clinical_history
  validates :date_submitted, presence: true

  def clinical_history_description
    clinical_history.try(:description) || ""
  end

  def clinical_history_description=(new_description)
    if self.clinical_history
      raise :not_implemented_yet
    else
      history = ClinicalHistory.create!(date: Date.today,
                                        description: new_description)
      self.clinical_history = history
      self.save
    end
  end

  def imported?
    imported_on.present?
  end
end
