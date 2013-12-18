class CarPool < ActiveRecord::Base
  attr_accessible :name, :number_of_member, :member_limit, :school_id
  
  validates :name, :number_of_member, :member_limit, :school_id, presence: true
  validates :number_of_member, :member_limit, numericality: { only_integer: true }
  
  has_many :students, :dependent => :nullify
  has_many :car_pool_users
  has_many :users, through: :car_pool_users
  belongs_to :school
  has_one :schedule, dependent: :destroy
end
