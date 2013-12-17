class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.integer :student_id
      t.integer :car_pool_id

      t.timestamps
    end
  end
end