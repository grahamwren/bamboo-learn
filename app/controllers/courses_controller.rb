class CoursesController < ApplicationController
  def index
    @courses = Course.all
    render 'index'
  end

  def edit
    @course = Course.find(params[:id])
    render 'edit'
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

  def course_params
    params.require(:course).permit(:short_name, :long_name, :description, :instructor_id)
  end
end
