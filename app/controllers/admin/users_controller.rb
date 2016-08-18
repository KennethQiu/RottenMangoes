class Admin::UsersController < ApplicationController

  before_action do
    unless current_user.is_admin?
      flash[:notice] = "No Admin for you! RAWR!"
      redirect_to '/'
    end
  end

  def index
    @users = User.all
  end

end
