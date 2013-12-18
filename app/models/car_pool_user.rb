class CarPoolUser < ActiveRecord::Base
  attr_accessible :car_pool_id, :user_id

  validates :car_pool_id, :user_id, numericality: { only_integer: true }, presence: true
  
  belongs_to :user
  belongs_to :car_pool
end