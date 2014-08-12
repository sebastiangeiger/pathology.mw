class CreateClinicalHistories < ActiveRecord::Migration
  def change
    create_table :clinical_histories do |t|
      t.references :patient, index: true
      t.text :description
      t.date :date

      t.timestamps
    end
  end
end
