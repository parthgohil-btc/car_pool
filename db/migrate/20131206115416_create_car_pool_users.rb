class CreateCarPoolUsers < ActiveRecord::Migration
  def change
    create_table :car_pool_users do |t|
      t.integer :car_pool_id
      t.integer :user_id

     

      t.timestamps
    end 
    add_index :car_pool_users, :car_pool_id
	  add_index :car_pool_users, :user_id
  	add_index :car_pool_users, [:car_pool_id, :user_id], unique: true
  end
end
