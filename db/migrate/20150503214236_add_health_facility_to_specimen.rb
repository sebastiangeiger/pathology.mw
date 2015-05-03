class AddHealthFacilityToSpecimen < ActiveRecord::Migration
  def change
    add_reference :specimens, :health_facility, index: true
  end
end
