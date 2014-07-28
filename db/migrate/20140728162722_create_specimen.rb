class CreateSpecimen < ActiveRecord::Migration
  def change
    create_table :specimens do |t|
      t.references :patient, index: true
      t.string :description
      t.string :diagnosis
      t.text :notes
      t.string :pathology_number
      t.date :date_submitted

      t.timestamps
    end
  end
end
