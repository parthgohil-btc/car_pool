class AddSchoolIdToCarPool < ActiveRecord::Migration
  def change
  	add_column :car_pools, :school_id, :integer
  end
end