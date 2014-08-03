class AddClinicalHistoryIdToSpecimens < ActiveRecord::Migration
  def change
    add_column :specimens, :clinical_history_id, :integer
  end
end
