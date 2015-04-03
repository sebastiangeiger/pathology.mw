class Specimen < ActiveRecord::Base
  belongs_to :patient
  belongs_to :clinical_history
  validates :date_submitted, presence: true
  validate :pathology_number_follows_pattern

  PATHOLOGY_REGEX = /^20\d{2}-QT-\d{1,5}$/
  CLOSE_ENOUGH_PATHOLOGY_REGEX = /^(20\d{2})-(\d{1,5})$/


  def clinical_history_description
    clinical_history.try(:description) || ""
  end

  def clinical_history_description=(new_description)
    if self.clinical_history
      raise :not_implemented_yet
    else
      history = ClinicalHistory.create!(date: Time.zone.today,
                                        description: new_description)
      self.clinical_history = history
      self.save
    end
  end

  def imported?
    imported_on.present?
  end

  def pathology_number=(new_number)
    matchdata = new_number.match(CLOSE_ENOUGH_PATHOLOGY_REGEX)
    new_number = "#{matchdata[1]}-QT-#{matchdata[2]}" if matchdata
    write_attribute(:pathology_number, new_number)
  end

  def pathology_number
    read_attribute(:pathology_number) || "#{Time.zone.today.year}-QT-"
  end

  private
  def pathology_number_follows_pattern
    unless pathology_number == :invalid or pathology_number =~ PATHOLOGY_REGEX
      errors.add(:pathology_number, "should adhere to this pattern 20XX-QT-XXXX")
    end
  end
end
