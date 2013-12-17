class CreateCarPools < ActiveRecord::Migration
  def change
    create_table :car_pools do |t|
      t.string :name
      t.integer :number_of_member

      t.timestamps
    end
  end
end
