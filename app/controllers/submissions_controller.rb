class SubmissionsController < ApplicationController
  before_action :authenticate_user!

  def index
    set_submission_and_assignment
    if current_user.teacher?
      # group submissions by user and then get only latest
      @submissions = []
      @assignment.submissions.collect(&:user_id).to_set.each do |u_id|
        @submissions << @assignment.submissions.where(user_id: u_id).order('created_at desc').first
      end
    else
      @submissions = @assignment.submissions.where(user_id: current_user.id).sort_by(&:created_at).reverse
    end
    render 'index'
  end

  def show
    set_submission_and_assignment
    if @submission.user == current_user || @assignment.course.instructor == current_user
      render 'show'
    else
      flash[:error] = 'Access Denied'
      index
    end
  end

  def new
    set_submission_and_assignment
    if @assignment.course.students.exists?(current_user.id)
      render 'new'
    else
      index
    end
  end

  def create
    set_submission_and_assignment
    if @assignment.course.students.exists?(current_user.id) &&
        current_user.id == submission_create_params[:user_id].to_i &&
        @assignment.due_date >= DateTime.now
      @submission = Submission.new submission_create_params
      if @submission.valid?
        @submission.save!
        index && return
      else
        flash[:error] = 'Invalid'
        render 'new'
      end
    else
      flash[:error] = 'Access Denied'
      redirect_to assignment_submissions_path(@assignment)
    end
  end

  def edit
    set_submission_and_assignment
    if @assignment.course.instructor == current_user
      render 'edit'
    else
      flash[:error] = 'Access denied'
      redirect_to assignment_submissions_path(@assignment)
    end
  end

  def update
    set_submission_and_assignment
    if @assignment.course.instructor == current_user
      if @submission.update! submission_update_params
        redirect_to assignment_submissions_path(@assignment)
      else
        flash[:error] = 'Something went wrong'
        render 'edit'
      end
    else
      flash[:error] = 'Access denied'
      redirect_to assignment_submissions_path(@assignment)
    end
  end

  private

  def submission_create_params
    params.require(:submission).permit(:user_id, :assignment_id, :text)
  end

  def submission_update_params
    params.require(:submission).permit(:grade)
  end

  def set_submission_and_assignment
    @submission ||= params[:id] ? Submission.find(params[:id]) : Submission.new(user: current_user)
    @assignment ||= @submission.assignment || Assignment.find(params[:assignment_id])
    @submission.assignment ||= @assignment
  end
end
