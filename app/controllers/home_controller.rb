class HomeController < ApplicationController
  	
  	before_filter :authenticate_user!
	
	def index
	end

	def new_profile
		@profile = Profile.new
	end

	def create_profile
		params[:profile]["user_id"] = current_user.id
		profile = Profile.create(params[:profile])
		if profile.save
			redirect_to new_address_path
		else
			@profile = Profile.new(params[:profile])
			flash[:error] = "Error has occurred"
			render :new_profile
		end
	end

	def edit_profile
		@profile = current_user.profile
	end

	def update_profile
		profile = current_user.profile
		if profile.update_attributes(params[:profile])
			redirect_to root_path
			flash[:notice] = "Profile updated"
		else
			@profile = Profile.new(params[:profile])
			flash.now[:alert] = "Error has ocurred will updating profile"
			render :edit_profile
		end
	end

	def new_address
		@address = Address.new
	end

	def create_address
		address = Address.create(address: params[:address], role: "user")
		if address.save
			current_user.update_attributes(address_id: address.id)
			redirect_to root_path
		else
			flash.now[:alert] = "Error has occurred"
			render :new_address
		end
	end

	def edit_address
	end

	def update_address
		address = current_user.address
		if address.update_attributes(address: params[:address])
			redirect_to root_path
			flash[:notice] = "Address updated"
		else
			flash[:error] = "Please enter address"
			render :edit_address
		end
	end
end