class AddStainsAndGrossToSpecimen < ActiveRecord::Migration
  def change
    add_column :specimens, :gross, :text
    add_column :specimens, :stains, :text
  end
end
