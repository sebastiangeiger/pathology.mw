class MakeDistrictAStringInPatient < ActiveRecord::Migration
  def change
    remove_column :patients, :district_id
    add_column :patients, :district, :string
  end
end
