class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :name
      t.string :stardard
      t.integer :user_id
      t.integer :school_id
      t.integer :car_pool_id

      t.timestamps
    end
  end
end
