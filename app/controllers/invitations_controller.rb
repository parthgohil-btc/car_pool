class InvitationsController < ApplicationController
  def index
    find_invitations
  end

  def show
    addresses = []
    car_pool = Invite.find(params[:id]).car_pool
    car_pool_users = car_pool.users
    current_user_address = current_user.address
    addresses << current_user_address
    school_address = car_pool.school.address
    car_pool_users.map do |user|
      addresses << user.address
    end
    map(addresses, current_user_address, school_address)
  end

  def select
    @students = current_user.students.where(school_id: params[:school_id])
    @invite_id = params[:id]
  end
  
  def accept
    invite = Invite.find(params[:id])
    car_pool = invite.car_pool
    student = invite.student
    student.car_pool = car_pool
    student.save
    car_pool.update_attributes(number_of_member: car_pool.number_of_member + 1)
    current_user.car_pool_users.create!(car_pool_id: car_pool.id)
    Invite.where(invited_student: invite.student.id).destroy_all
    find_invitations
  end

  def reject
    Invite.find(params[:id]).destroy
    find_invitations
  end
  
  private
  def find_invitations
    students_id = current_user.students.pluck(:id)
    @invites = Invite.where(invited_student: students_id)
  end

  def set_map_bubble(marker, url)
    marker.picture({ 
      "url" => url,
      "width" =>  33,
      "height" => 32 })
  end

  def map(addresses, current_user_address, school_address)
    @hash = Gmaps4rails.build_markers(addresses) do |address, marker|
      marker.lat address.latitude
      marker.lng address.longitude
      distance = current_user_address.distance_from([address.latitude, address.longitude])
      if address.user == current_user
        infowindow = "me"
        set_map_bubble(marker, "http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=me|F00000|000000")
      else
        set_map_bubble(marker, "http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=|F00000|000000")
        infowindow = "#{address.user.email} is #{(distance).round(3)} km from you"
      end
      marker.infowindow infowindow
    end
    distance = current_user_address.distance_from([school_address.latitude, school_address.longitude])
    @hash << { lat: school_address.latitude, lng: school_address.longitude, infowindow:  "#{school_address.school.name} distance is #{distance.round(3)}", picture: { url: "http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=s|F00000|000000", width: 33, height: 32 }}
  end

  def set_map_bubble(marker, url)
    marker.picture({ 
      "url" => url,
      "width" =>  33,
      "height" => 32})
  end
end