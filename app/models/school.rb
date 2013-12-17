class School < ActiveRecord::Base
  attr_accessible :address_id, :name
  has_many :students
  has_many :car_pools
  belongs_to :address, dependent: :destroy

end
