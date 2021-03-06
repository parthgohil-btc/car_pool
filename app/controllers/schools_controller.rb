class SchoolsController < ApplicationController
  def index
    school_map
  end

  def create
    address = Address.create(address: params["school"]["name"] + ', ' + params[:address], role: "school")
    if address.save
      params[:school][:address_id] = address.id
      school = School.create(params[:school])
      if school.save
        @schools = School.all
      else
        address.destroy
        render "new"
      end
    else

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
    school = School.find(params[:id])
    unless params[:address].nil?
      school_address = params[:school][:name] + ", " + params[:address]
    end
    if school.update_attributes(params[:school])
      school.address.update_attributes(address: school_address)
      flash[:notice] = "school updated"
    else
      flash[:alert] = "update failed"
    end
    school_map
  end

  def delete
    if School.find(params[:id]).destroy
      @schools = School.all
    else

    end

  end
  
  def edit
    @School = School.find(params[:id])
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