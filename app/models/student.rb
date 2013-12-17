class Student < ActiveRecord::Base
  attr_accessible :car_pool_id, :name, :school_id, :stardard, :user_id
  belongs_to :car_pool
  belongs_to :school
  belongs_to :user
  has_one :schedule
end
