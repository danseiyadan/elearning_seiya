class Admin::UsersController < ApplicationController
  before_action :admin_login

  def update
    @user = User.find(params[:id])
    @user.update!(admin_params)
    if @user.is_admin
      flash[:success] = "#{@user.name} is now admin"
    else
      flash[:success] = "#{@user.name} is no longer admin"
    end
    redirect_to users_path
  end

  private
  def admin_params
    params.permit(:is_admin)
  end
end
