class PagesController < ApplicationController
  def home
    unless logged_in?
      redirect_to login_path
    end
    if logged_in?
      @activities = Activity.where("user_id = ?", current_user.id)
      @lessons = current_user.lessons.where("created_at >= ?", Date.today)
    end
  end

  def about
  end
end
