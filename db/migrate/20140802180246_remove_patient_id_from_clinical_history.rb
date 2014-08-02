class RemovePatientIdFromClinicalHistory < ActiveRecord::Migration
  def change
    remove_column :clinical_histories, :patient_id
  end
end
