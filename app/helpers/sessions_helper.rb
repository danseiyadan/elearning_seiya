module SessionsHelper
  def log_in(user) #ここの引数はこのメソッドを呼び出した時に指定する？
    session[:user_id] = user.id #ここはこういうものとする。
  end
  # log_inアクションを使うとログインできる。これをsessionコントローラー上で使っている。
  
  def current_user
    User.find_by(id: session[:user_id]) 
    # @current_user ||= に上記を代入するのが一般的？
  end
  # current_userとはidがsession[:user_id]のuserすなわちそのdevice上でloginしているuser.

  def logged_in?
    !current_user.nil?
  end
  # current_userがいるかどうか、すなわちログインしているかのチェック。

  def log_out
    session.delete(:user_id)
  end
  # よくわからないけど、destroyはモデルがないとだめ？
  # sessionを消すことでログアウトするみたい。

  # def logged_in_user
  #   unless logged_in?
  #     flash[:info] = "Please login first."
  #     redirect_to login_url
  #   end
  # end
  # only_loggedin_usersの機能とかぶっているからいらないはず。。

  def current_user?(user)
    return true if user == current_user
  end
  # current_userかどうかの判断。ビューで判断結果を使うために、application_controlerで読み込んでいるこのページで定義。
  # メソッドでも使えるからいくつか綺麗にできるかも？

  def only_loggedin_users
    unless logged_in?
      flash[:danger] = "Please login first."
      redirect_to login_url
    end
  end

  def admin_user?
    current_user.is_admin
  end
end
