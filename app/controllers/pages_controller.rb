class PagesController < ApplicationController
  def home
    unless logged_in?
      redirect_to login_path
    end
    if logged_in?
      @activities = Activity.all
      @lessons = current_user.lessons.where("created_at >= ?", Date.today).where("result IS NOT NULL").paginate(page: params[:page], per_page: 3)
      @users = User.all
    end
  end

  def about
  end
end
