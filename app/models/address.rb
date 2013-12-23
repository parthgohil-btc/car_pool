class Address < ActiveRecord::Base
  attr_accessible :address, :latitude, :longitude, :role

  has_one :user
  has_one :school, dependent: :destroy
  has_one :request

  geocoded_by :address
  after_validation :geocode

  validates :address, presence: true
  # validates :latitude, :longitude

  def self.distance(latitude, longitude)
    self.near([latitude, longitude], 5, :units => :km)
  end

  def self.find_address(id)
    self.find(id)
  end

end