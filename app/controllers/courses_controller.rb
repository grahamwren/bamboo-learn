class CoursesController < ApplicationController
  before_action :authenticate_user!

  def index
    @courses = Course.all
    render 'index'
  end

  def edit
    @course = Course.find(params[:id])
    render 'edit'
  end

  def show
    @course = Course.find(params[:id])
    unless current_user.courses.exists?(@course.id) || @course.instructor == current_user
      edit && return
    end
    @assignments = @course.assignments.where due_date: nil
    @assignments += @course.assignments.where('due_date is not null').sort_by &:due_date
    render 'show'
  end

  def new
    if current_user.admin?
      @course = Course.new
      render 'new'
    else
      redirect_to courses_path, status: :unauthorized, alert: "Access Denied"
    end
  end

  def update
    if current_user.admin?
      @course = Course.find params[:id]
      @course.update course_params
      flash[:success] = "Course updated"
      render 'edit'
    else
      redirect_to courses_path, status: :unauthorized, alert: "Access Denied"
    end
  end

  def create
    if current_user.admin?
      @course = Course.new course_params
      if @course.valid?
        @course.save!
        flash[:success] = @course.short_name + ' was created successfully'
        index
      else
        render 'new'
      end
    else
      redirect_to courses_path, status: :unauthorized, alert: "Access Denied"
    end
  end

  def destroy
    if current_user.admin?
      @course = Course.find params[:id]
      if @course.destroy
        flash[:notice] = @course.short_name + ' deleted'
      else
        flash[:alert] = 'Delete failed'
      end
      index
    else
      redirect_to courses_path, status: :unauthorized, alert: "Access Denied"
    end
  end

  def add_self
    @course = Course.find(params[:id])
    if @course.students << current_user
      flash[:success] = 'Added class ' + @course.short_name
    end
    redirect_to courses_path
  end

  def drop_self
    @course = Course.find(params[:id])
    if @course.students.destroy current_user
      flash[:success] = 'Dropped class ' + @course.short_name
      redirect_to root_path
    else
      flash[:alert] = 'Unable to drop class'
    end
  end

  def course_params
    params.require(:course).permit(:short_name, :long_name, :description, :instructor_id)
  end
end
