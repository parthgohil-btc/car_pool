class SchoolsController < ApplicationController
  before_filter :authenticate_user!, :check_address_and_profile
  
  def index
    school_map
  end

  def create
    address = Address.new(address: params["school"]["name"] + ', ' + params[:address], role: "school")
    if params[:address].present? && address.save
      params[:school][:address_id] = address.id
      school = School.new(params[:school])
      if school.save
        @schools = School.all
        flash.now[:notice] = "School created"
      else
        @school = School.new(params[:school])
        address.destroy
        flash.now[:alert] = "Error has ocurred"
        render "new"
      end
    else
      @school = School.new(params[:school])
      flash.now[:alert] = "Error has ocurred"
      render "new"
    end
  end

  def new
    @school = School.new
  end

  def show
  end

  def search
  end

  def update
    @school = School.find(params[:id])
    if params[:address].present? && @school.update_attributes(params[:school])
      school_address = params[:school][:name] + ", " + params[:address]
      @school.address.update_attributes(address: school_address)
      @schools = School.all
      flash.now[:notice] = "school updated"
    else
      flash.now[:alert] = "update failed"
      render :edit
    end
    school_map
  end

  def delete
    if School.find(params[:id]).destroy
      @schools = School.all
      flash.now[:notice] = "School deleted"
    else
      flash[:alert] = "Failed to delete the school"
    end

  end
  
  def edit
    @school = School.find(params[:id])
  end

  private
  
  def school_map
   @schools = School.all
   current_user_address = Address.find_all_by_role("school")
    @hash = Gmaps4rails.build_markers(current_user_address) do |address, marker|
      marker.lat address.latitude
      marker.lng address.longitude
      marker.infowindow address.school.name
    end
  end
end