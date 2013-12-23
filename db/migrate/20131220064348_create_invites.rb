class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.integer :invited_student
      t.integer :car_pool_invite

      t.timestamps
    end
	add_index :invites, :car_pool_invite
    add_index :invites, :invited_student
    add_index :invites, [:car_pool_invite, :invited_student], unique: true
  end
end
