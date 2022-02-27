class PagesController < ApplicationController
  def home
    unless logged_in?
      redirect_to login_path
    end
  end

  def about
  end
end
