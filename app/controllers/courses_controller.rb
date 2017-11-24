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

end
