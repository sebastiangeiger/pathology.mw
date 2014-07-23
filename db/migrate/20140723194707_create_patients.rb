class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.string :first_name
      t.string :middle_names
      t.string :last_name
      t.string :gender
      t.date :birthday
      t.date :birthyear
      t.integer :district_id

      t.timestamps
    end
  end
end
