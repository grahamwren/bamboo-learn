require 'securerandom'

class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    render 'index'
  end

  def new
    if current_user.admin?
      @user = User.new
      render 'new'
    else
      redirect_to users_path, alert: "Access Denied"
    end
  end

  def create
    if current_user.admin?
      @user = User.new(user_params.merge({ password: SecureRandom.hex(64) }))
      if @user.valid?
        @user.save!
        index
      else
        render 'new'
      end
    else
      redirect_back alert: 'Access Denied'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user == current_user || current_user.admin?
      @user.update(user_params)
      render 'edit', notice: 'User updated'
    else
      redirect_back alert: 'Access Denied.'
    end
  end

  def show
    @user = User.find(params[:id])
    if @user == current_user || current_user.admin?
      edit
    else
      render 'show'
    end
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user || current_user.admin?
      render 'edit'
    else
      redirect_back alert: 'Access denied.'
    end
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :user_type, :school_id, :dob)
  end

end