class CreatePhysicians < ActiveRecord::Migration
  def change
    create_table :physicians do |t|
      t.string :first_name
      t.string :last_name
      t.string :title

      t.timestamps
    end
  end
end
