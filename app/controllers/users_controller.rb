require 'securerandom'

class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    render 'index'
  end

  def new
    if current_user.user_type.to_sym != :admin
      redirect_to users_path, alert: "Access Denied"
    else
      @user = User.new
      render 'new'
    end
  end

  def create
    @user = User.new(user_params.merge({ password: SecureRandom.hex(64) }))
    if @user.valid?
      @user.save!
      render 'edit'
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    render 'edit', notice: "User updated"
  end

  def show
    @user = User.find(params[:id])
    if @user == current_user || current_user.user_type.to_sym == :admin
      edit
    else
      render 'show'
    end
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user || current_user.user_type.to_sym == :admin
      render 'edit'
    else
      redirect_back alert: "Access denied."
    end
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :user_type, :school_id, :dob)
  end

end