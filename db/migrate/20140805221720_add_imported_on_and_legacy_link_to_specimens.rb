class AddImportedOnAndLegacyLinkToSpecimens < ActiveRecord::Migration
  def change
    add_column :specimens, :imported_on, :date
    add_column :specimens, :legacy_link, :string
  end
end
