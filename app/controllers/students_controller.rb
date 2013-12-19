class StudentsController < ApplicationController
  before_filter :authenticate_user!, :check_address_and_profile
  
  def index
    @students = current_user.students
  end

  def new
    @student = Student.new
  end

  def create
    logger.info "------params[:student][:school_id].nil?---..#{params[:student][:school_id]}-/-------#{params[:student][:school_id].nil?}"
    student = Student.new(name: params[:student][:name], user_id: current_user.id, stardard: params[:student][:stardard].to_i, school_id: params[:student][:school_id].to_i)
    if !params[:student][:stardard].empty? && student.save
      flash.now[:notice] = "new student created successfully"
      @students = current_user.students
      # redirect_to root_path
    else
      flash.now[:alert] = "student create failed"
      @student = Student.new(params[:student])
      render :new
    end
  end

  def search
  end

  def show
  end

  def delete
    student = Student.find(params[:id])
    if student.present?
      if student.schedule.present?
        Schedule.set_schedule(student.car_pool)
      end
      if student.car_pool.present? && !student.car_pool.students.present?
        student.car_pool.destroy
      end
      student.destroy
      @students = current_user.students
      flash.now[:notice] = "student deleted successfully"
    else
      flash.now[:alert] = "student delete failed"
    end
  end

  def update
    @student = Student.find(params[:id])
    if @student.update_attributes(params[:student])
      flash.now[:notice] = "student details updated"
      @students = current_user.students
    else
      flash.now[:alert] = "please check student details fields"
      render :edit
    end
  end

  def edit
    @student = Student.find(params[:id])
  end

end
