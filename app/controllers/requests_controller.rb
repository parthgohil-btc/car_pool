class RequestsController < ApplicationController
  
  def new
  	@request = Request.new
  end

  def show
    request = Request.find(params[:id])
    request_address = request.address
    @hash = [{ lat: request_address.latitude, lng: request_address.longitude, infowindow:  "#{request.name}", picture: { url: "http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=s|F00000|000000", width: 33, height: 32 }}]
  end

  def create
  	address = Address.new(address: params[:request][:name] +', '+ params[:address], role: 'school_request')
  	if params[:request][:name].present? && address.save
  		request = Request.new(address_id: address.id, name: params[:request][:name], user_id: current_user.id)
  		if request.save
  			flash.now[:notice] = "School request send"
  			@request = Request.new
  		else
  			address.destroy
  			request_create_failed
  		end
  	else
  		request_create_failed
  	end
  end

  def index
    find_all_request
  end

  def delete
    Request.find(params[:id])
    find_all_request
  end

  def accept
    request = Request.find(params[:id])
    School.create(name: request.name, address_id: request.address_id)
    request.destroy
    find_all_request
    flash.now[:notice] = "Request accepted"
  end

  def reject
    request = Request.find(params[:id])
    request.address.destroy
    request.destroy
    find_all_request
    flash.now[:notice] = "Request rejected"
  end

  private
  def find_all_request
    @requests = Request.all
  end
  
  def request_create_failed
  	@request = Request.new(params[:request])
    render :new
  	flash.now[:alert] = "School request failed"
  end
end