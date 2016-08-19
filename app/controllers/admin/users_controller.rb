class Admin::UsersController < ApplicationController

  before_action :admin_restriction, except: [:end_impersonate]

  def admin_restriction
    unless current_user.is_admin?
      flash[:notice] = "No Admin for you! RAWR!"
      redirect_to '/'
    end
  end

  def index
    @users = User.all.page(params[:page]).per(5)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "User #{@user.firstname} updated!"
    else
      render admin_user_edit_path(@user)
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_users_path, notice: "New user #{@user.firstname} added!"
    else
      render :new
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice: "User #{@user.firstname} deleted!"
  end

  def impersonate 
    session[:orig_user_id] = session[:user_id]
    session[:user_id] = params[:id]
    redirect_to root_path 
  end

  def end_impersonate
    session[:user_id] = session[:orig_user_id]
    session.delete(:orig_user_id)
    redirect_to admin_users_path
  end

  protected

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation, :is_admin)
  end

end
