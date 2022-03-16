class ApplicationController < ActionController::Base
  include SessionsHelper

  def admin_login
    unless logged_in? && admin_user?
      flash[:danger] = "You are not authorized"
      redirect_to root_path
    end
  end
end
