class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(user)
  	if current_user.profile.present?
  		root_path
  	else
    	new_profile_path
    end
  end

	def check_address_and_profile
    if !current_user.profile.present?
      redirect_to new_profile_path
    elsif !current_user.address.present?
      redirect_to new_address_path
    end
  end
end
