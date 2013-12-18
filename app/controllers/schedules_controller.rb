class SchedulesController < ApplicationController
  before_filter :authenticate_user!, :check_address_and_profile
  def index
  end
  
end