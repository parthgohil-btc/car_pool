class StudentsController < ApplicationController
  def index
    @students = current_user.students
  end

  def new
    @student = Student.new
  end

  def create
    params[:student][:user_id] = current_user.id
    student = Student.create(params[:student])
    if student.save
      flash.now[:notice] = "new student created successfully"
      @students = current_user.students
      # redirect_to root_path
    else
      flash[:alert] = "student create failed"
      @student = params[:student]
      render new_address
    end
  end

  def search
  end

  def show
  end

  def delete
    student = Student.find(params[:id])
    if student.present?
      student.destroy
      @students = current_user.students
      flash.now[:notice] = "student deleted successfully"
    else
      flash.now[:alert] = "student delete failed"
    end
  end

  def update
    if Student.find(params[:id]).try(:update_attributes, params[:student])
      flash.now[:notice] = "student updated successfully"
      @students = current_user.students
    else
      flash.now[:alert] = "please check student details fields"
      render "edit"
    end
  end

  def edit
    @student = Student.find(params[:id])
  end

end
