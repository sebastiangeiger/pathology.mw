class ChangePatientBirthyearFromDateToNumber < ActiveRecord::Migration
  def change
    change_column :patients, :birthyear, :integer
  end
end
