class CreateHealthFacilities < ActiveRecord::Migration
  def change
    create_table :health_facilities do |t|
      t.string :name
      t.text :postal_address
      t.references :district
      t.string :telephone

      t.timestamps
    end
  end
end
