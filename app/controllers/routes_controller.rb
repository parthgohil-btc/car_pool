class RoutesController < ApplicationController
  before_filter :authenticate_user!, :check_address_and_profile, except: :index

  def index
    if user_signed_in?
    #   current_user_address = Address.find(current_user.address_id)
    #   @hash = Gmaps4rails.build_markers(current_user_address) do |address, marker|
    #     marker.lat address.latitude
    #     marker.lng address.longitude
    #     marker.infowindow "me"
    #   end
      check_address_and_profile
    end
  end

  def search
  end

  def show
    current_user_address = Address.find(current_user.address_id)
    # near_by_address = Address.distance(address.latitude, address.longitude)
    distance = 5
    center_point = [current_user_address.latitude, current_user_address.longitude]
    box = Geocoder::Calculations.bounding_box(center_point, distance, :units => :km)
    near_by_address = Address.within_bounding_box(box)
    @hash = Gmaps4rails.build_markers(near_by_address) do |address, marker|
      marker.lat address.latitude
      marker.lng address.longitude
      distance = current_user_address.distance_from([address.latitude,address.longitude])
      if distance == 0
        infowindow = "me"
      else
        infowindow = "#{(distance).round(3)}"
      end
      marker.infowindow infowindow
    end
  end

  def new
  end

  def create
  end
  
end