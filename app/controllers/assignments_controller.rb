class AssignmentsController < ApplicationController
  before_action :authenticate_user!

  def new
    set_course
    if current_user.admin? || @course.instructor == current_user
      @assignment = @course.assignments.new
      render 'new'
    else
      flash[:error] = 'Access Denied'
      redirect_to course_path(@course)
    end
  end

  def create
    set_course
    if current_user.admin? || @course.instructor == current_user
      @assignment = @course.assignments.new assignment_params
      if @assignment.valid?
        @assignment.save!
        flash[:success] = 'Created assignment ' + @assignment.name
        redirect_to course_path(@course)
      else
        render 'new'
      end
    else
      flash[:error] = 'Access Denied'
      redirect_to course_path(@course)
    end
  end

  def index
    set_course
    if @course.students.exists?(current_user.id) || current_user == @course.instructor
      @assignments = @course.assignments
      render 'index'
    else
      flash[:error] = 'Access Denied'
      redirect_to course_path(@course)
    end
  end

  def show
    @assignment = Assignment.find params[:id]
    if @assignment.course.students.exists?(current_user.id) ||
        current_user == @assignment.course.instructor
      render 'show'
    else
      flash[:error] = 'Access Denied'
      redirect_to course_path(@assignment.course)
    end
  end

  def edit
    @assignment = Assignment.find params[:id]
    if @assignment.course.instructor == current_user || current_user.admin?
      render 'edit'
    else
      flash[:error] = 'Access Denied'
      redirect_to course_path(@assignment.course)
    end
  end

  def update
    @assignment = Assignment.find params[:id]
    if @assignment.course.instructor == current_user || current_user.admin?
      if @assignment.update assignment_params
        flash[:success] = 'Updated'
      else
        flash[:error] = 'Unable to update'
      end
      render 'edit'
    else
      flash[:error] = 'Access Denied'
      redirect_to course_path(@assignment.course)
    end
  end

  def destroy
    @assignment = Assignment.find params[:id]
    if @assignment.course.instructor == current_user || current_user.admin?
      if @assignment.destroy
        flash[:success] = 'Deleted ' + @assignment.name
      else
        flash[:error] = 'Unable to destroy ' + @assignment.name
      end
      redirect_to course_path(@assignment.course)
    else
      flash[:error] = 'Access Denied'
      redirect_to course_path(@assignment.course)
    end
  end

  def set_course
    @course = Course.find(params[:course_id] || assignment_params[:course_id])
  end

  def assignment_params
    params.require(:assignment).permit(:name, :description, :due_date, :course_id)
  end
end
