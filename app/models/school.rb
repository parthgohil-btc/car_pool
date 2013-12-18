class School < ActiveRecord::Base
  attr_accessible :address_id, :name

  validates :name, :address_id, presence: true
  validates :address_id, numericality: { only_integer: true }

  has_many :students, :dependent => :nullify
  has_many :car_pools, dependent: :destroy
  belongs_to :address, dependent: :destroy
  scope :find_all_schools, lambda { |school_id| where('id = ?', school_id) }

end
