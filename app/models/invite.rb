class Invite < ActiveRecord::Base
  attr_accessible :car_pool_invite, :invited_student

  belongs_to :student, :foreign_key => :invited_student
  belongs_to :car_pool, :foreign_key => :car_pool_invite
end
