class Student < ActiveRecord::Base
  attr_accessible :car_pool_id, :name, :school_id, :stardard, :user_id

  validates :name, :school_id, :stardard, :user_id, presence: true
  validates :school_id, :user_id, numericality: { only_integer: true }
	# validates :school_id, :car_pool_id,
  belongs_to :car_pool
  belongs_to :school
  belongs_to :user
  has_one :schedule, :dependent => :nullify
end
