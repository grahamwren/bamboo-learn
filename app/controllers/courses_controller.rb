class CoursesController < ApplicationController
  def index
    @courses = Course.all
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
      @course.update(course_params)
      render 'edit', success: 'User updated'
    else
      redirect_to courses_path, status: :unauthorized, alert: "Access Denied"
    end
  end

  def course_params
    params.require(:course).permit(:short_name, :long_name, :description, :instructor_id)
  end
end
