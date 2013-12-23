class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.integer :user_id
      t.string :name
      t.integer :address_id
      t.timestamps
    end
  end
end
