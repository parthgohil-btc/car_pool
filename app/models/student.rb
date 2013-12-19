class Student < ActiveRecord::Base
  attr_accessible :car_pool_id, :name, :school_id, :stardard, :user_id

  validates :name, :school_id, :stardard, :user_id, presence: true
  validates :school_id, :stardard, :user_id, numericality: { only_integer: true }, :inclusion => { :in => 1..12 }
	# validates :school_id, :car_pool_id,
  belongs_to :car_pool
  belongs_to :school
  belongs_to :user
  has_one :schedule, :dependent => :nullify

  scope :students_dont_have_join_car_pool, -> { where car_pool_id: nil }  
  scope :find_students, lambda { |student_ids| where('id = ?', student_ids) }

end
