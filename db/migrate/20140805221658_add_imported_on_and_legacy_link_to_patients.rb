class AddImportedOnAndLegacyLinkToPatients < ActiveRecord::Migration
  def change
    add_column :patients, :imported_on, :date
    add_column :patients, :legacy_link, :string
  end
end
