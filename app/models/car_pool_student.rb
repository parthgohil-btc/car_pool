class CarPoolStudent < ActiveRecord::Base
  attr_accessible :car_pool_invite, :invited_student

  belongs_to :student
  belongs_to :car_pool
end
