class ChangePatientBirthyearFromDateToNumber < ActiveRecord::Migration
  def change
    remove_column :patients, :birthyear
    add_column :patients, :birthyear, :integer
  end
end
