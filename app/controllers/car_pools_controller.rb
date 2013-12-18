class CarPoolsController < ApplicationController
  before_filter :authenticate_user!, :check_address_and_profile
  
  def index
    car_pools_id = current_user.car_pools.pluck(:id)
    @car_pools = CarPool.where(id: car_pools_id).page(params[:page]).per(5)
  end

  def new
    @car_pool = CarPool.new
    @students = current_user.students.where(car_pool_id: nil)
    school_list(@students)
  end

  def create
    if params[:student_ids].present?
      params[:car_pool][:number_of_member] = params[:student_ids].length
    end
    car_pool = CarPool.create(params[:car_pool])
    if car_pool.save
      students = Student.where(id: params[:student_ids])
      students.update_all(car_pool_id: car_pool.id)
      current_user.car_pool_users.create(car_pool_id: car_pool.id)
      students.first.create_schedule(car_pool_id: car_pool.id)
      car_pools_id = current_user.car_pools.pluck(:id)
      @car_pools = CarPool.where(id: car_pools_id).page(params[:page]).per(5)
    else
      @students = current_user.students.where(car_pool_id: nil)
      school_list(@students)
      @car_pool = CarPool.new(params[:car_pool])
      render "new"
    end
  end

  def show
    @action = params[:pre_action]
    @students = Student.where(car_pool_id: params[:id])
    @distance = params[:distance]
    @school_id = params[:school_id]
  end

  def search_car_pool
    @action = params[:commit]
    logger.info "--@action #{@action}--------------#{params[:commit]}"
    if params[:school_id].present?
      map
    else
      @students = current_user.students
      school_list(@students)
      flash.now[:notice] = "Please select the school"
      render :search
    end
  end

  def show_car_pools
    car_pools_id = current_user.car_pools.pluck(:id)
    @car_pools = CarPool.where(id: car_pools_id).page(params[:page]).per(5)
  end

  def search
    @students = current_user.students
    school_list(@students)
  end

  def leave_car_pool
    student = Student.find(params[:id])
    car_pool = student.car_pool
    car_pool_user = current_user.car_pool_users
    if params[:size] == '1'
      car_pool.destroy
      render :js => "window.location = '/car_pools'"
    else
      car_pool.update_attributes(number_of_member: car_pool.number_of_member - 1)
      student.update_attributes(car_pool_id: nil)
      current_user_students_id = current_user.students.where(car_pool_id: car_pool.id)
        if current_user_students_id.count == 0
          CarPoolUser.where(user_id: current_user.id, car_pool_id: car_pool.id).destroy_all
        end
      @car_pools = current_user.car_pools
      if car_pool_user.nil?
        render :js => "window.location = '/car_pools'"
      end
    end
    find_addresses
  end

  def join
    @school_id = params[:school_id]
    @distance = params[:distance]
    @students = current_user.students.where(school_id: params[:school_id], car_pool_id: nil)
    @car_pool_id = params[:id]
  end

  def join_car_pool
    if params[:students_id].present?
      car_pool = CarPool.find(params[:id])
      students = Student.find_all_by_id(params[:students_id].map(&:to_i))
      number_of_member = car_pool.number_of_member
      car_pool.update_attributes(number_of_member: number_of_member + params[:students_id].size)
      students.each do |student|
        student.update_attributes(car_pool_id: car_pool.id)
      end
      @car_pool = CarPool.find(params[:id])
      current_user.car_pool_users.create(car_pool_id: car_pool.id) unless current_user.car_pool_users.where(car_pool_id: @car_pool.id).any?
      # @students = Student.where(school_id: @car_pool.school_id)
    else
      flash[:notice] = "Please select the student"
    end
    find_addresses
  end
  
  def update
  end
  
  def show_searched_car_pools
    find_addresses
  end
  
  private

  def set_map_bubble(marker, url)
    marker.picture({ 
      "url" => url,
      "width" =>  33,
      "height" => 32})
  end

  def find_addresses
    car_pools_id = []
    # @students = []
    near_by_address = []
    school = School.find(params[:school_id].to_i)
    current_user_address = Address.find(current_user.address_id)
    box = Geocoder::Calculations.bounding_box([current_user_address.latitude, current_user_address.longitude], params[:distance].presence || 2)
    all_near_by_address = Address.within_bounding_box(box)
    all_near_by_address.collect do |address|
      if address.role == "user"
        students = address.user.students
        students.each do |student|
          if student.school_id == params[:school_id].to_i
            # @students << student
            near_by_address << address
            unless student.car_pool_id.nil?
              car_pools_id << student.car_pool_id
            end
          end
        end
      end
    end
    @school_id = params[:school_id].to_i
    @distance = params[:distance].presence || 2
    @car_pools = CarPool.where(id: car_pools_id).uniq.page(params[:page]).per(5)
    # @students = @students.flatten
    addresses = [near_by_address, current_user_address, school]
  end

  def map
    addresses = find_addresses
    @hash = Gmaps4rails.build_markers(addresses[0].uniq) do |address, marker|
      marker.lat address.latitude
      marker.lng address.longitude
      distance = addresses[1].distance_from([address.latitude, address.longitude])
      if distance == 0
        infowindow = "me"
        set_map_bubble(marker, "http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=me|F00000|000000")
      else
        set_map_bubble(marker, "http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=|F00000|000000")
        infowindow = "#{current_user.email} #{(distance).round(3)} km from you"
      end
      marker.infowindow infowindow
    end
    distance = addresses[1].distance_from([addresses[2].address.latitude, addresses[2].address.longitude])
    @hash << { lat: addresses[2].address.latitude, lng: addresses[2].address.longitude, infowindow:  "#{addresses[2].name} distance is #{distance.round(3)}", picture: { url: "http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=s|F00000|000000", width: 33, height: 32 }}
  end

  def school_list(students)
    school_id = @students.pluck(:school_id)
    @schools = School.find_all_by_id(school_id).uniq
  end


end