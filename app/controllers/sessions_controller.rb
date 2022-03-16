class SessionsController < ApplicationController
  before_action :already_loggedin, only: :new

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      log_in(user)
      flash[:success] = "Successfully logged in"
      redirect_to root_url
    else
      flash.now[:danger] = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    log_out # sessionhelperで定義されている。
    flash[:success] = "Successfully logged out"
    redirect_to root_url
  end
end
