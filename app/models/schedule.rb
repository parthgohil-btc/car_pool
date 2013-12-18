class Schedule < ActiveRecord::Base
  attr_accessible :student_id, :car_pool_id

  validates :student_id, :car_pool_id, numericality: { only_integer: true }, presence: true
  
  belongs_to :student
  belongs_to :car_pool

	def self.set_schedule
		car_pools = CarPool.all
		car_pools.each do |car_pool|
			schedule = Schedule.find(car_pool.id)
			student_id = find_next_to_drive(car_pool, schedule)
			schedule.update_attributes(student_id: student_id)
			student = Student.find(student_id)
			Reminder.car_pool_reminder(student.user.email).deliver
		end

	end

	def self.find_next_to_drive(car_pool, schedule)
		students_id = car_pool.students.pluck(:id)
		student_index = students_id.index(schedule.student_id)
		student_id =
			if students_id[student_index] == students_id.last
		 		students_id.first
			else
				students_id[student_index + 1]
			end
		student_id
	end

end
