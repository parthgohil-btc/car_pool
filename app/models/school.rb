class School < ActiveRecord::Base
  attr_accessible :address_id, :name

  validates :name, :address_id, presence: true
  validates :address_id, numericality: { only_integer: true }

  has_many :students
  has_many :car_pools
  belongs_to :address, dependent: :destroy

end
