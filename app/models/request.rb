class Request < ActiveRecord::Base
  attr_accessible :user_id, :address_id, :name
  belongs_to :address
  belongs_to :user
end
