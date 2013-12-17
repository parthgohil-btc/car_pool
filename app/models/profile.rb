class Profile < ActiveRecord::Base
  attr_accessible :father_contact_number, :father_name, :mother_contact_number, :mother_name, :user_id
  validates :father_contact_number, :father_name, :mother_contact_number, :mother_name, :user_id, presence: true
  validates :mother_contact_number, :father_contact_number, numericality: { only_integer: true }

  belongs_to :user
end
