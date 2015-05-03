class ChangeDistrictIdToDistrictNameOnHealthFacilities < ActiveRecord::Migration
  def change
    remove_column :health_facilities, :district_id
    add_column :health_facilities, :district, :string
  end
end
