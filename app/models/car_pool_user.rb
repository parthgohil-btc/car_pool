class CarPoolUser < ActiveRecord::Base
  attr_accessible :car_pool_id, :user_id
  belongs_to :user
  belongs_to :car_pool
end