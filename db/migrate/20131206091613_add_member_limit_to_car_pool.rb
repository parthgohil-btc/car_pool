class AddMemberLimitToCarPool < ActiveRecord::Migration
  def change
  	add_column :car_pools, :member_limit, :integer
  end
end
