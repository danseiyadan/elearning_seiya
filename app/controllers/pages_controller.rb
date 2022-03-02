class PagesController < ApplicationController
  def home
    unless logged_in?
      redirect_to login_path
    end
    if logged_in?
      # @activities = Activity.where("user_id = ?", current_user.id)
      @activities = Activity.all
      @lessons = current_user.lessons.where("created_at >= ?", Date.today)
      @users = User.all
    end
  end

  def about
  end
end
