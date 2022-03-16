module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id 
  end
  # log_inアクションを使うとログインできる。これをsessionコントローラー上で使っている。
  
  def current_user
    User.find_by(id: session[:user_id]) 
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
  end

  def current_user?(user)
    user == current_user
  end

  def only_loggedin_users
    unless logged_in?
      flash[:danger] = "Please login first."
      redirect_to login_url
    end
  end

  def admin_user?
    current_user.is_admin
  end

  def already_loggedin
    if logged_in?
      redirect_to root_url
    end
  end
end
