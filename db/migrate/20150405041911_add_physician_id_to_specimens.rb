class AddPhysicianIdToSpecimens < ActiveRecord::Migration
  def change
    add_column :specimens, :physician_id, :integer
  end
end
