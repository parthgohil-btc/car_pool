class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :admin, :address_id
  # attr_accessible :title, :body

  has_one :profile, dependent: :destroy
  belongs_to :address, dependent: :destroy
  has_many :students, dependent: :destroy
  has_many :car_pool_users
  has_many :car_pools, through: :car_pool_users
  has_many :requests
end