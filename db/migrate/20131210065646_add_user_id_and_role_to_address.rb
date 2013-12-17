class AddUserIdAndRoleToAddress < ActiveRecord::Migration
  def change
  	add_column :addresses, :role, :string 
  end
end