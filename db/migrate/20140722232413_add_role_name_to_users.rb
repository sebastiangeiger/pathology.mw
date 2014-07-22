class AddRoleNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :role_name, :string, default: :guest
    add_index :users, :role_name
  end
end
