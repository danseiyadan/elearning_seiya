class SessionsController < ApplicationController
  def new
  end

  def create #sessionでのcreateはすなわちlogin
    user = User.find_by(email: params[:session][:email])
    # @をつけない理由はmodelがないから、またはビューで使わないから（orどちらも）っぽい。
    # 多分、params[:session]のためにform上でscope: sessionとしている。
    if user && user.authenticate(params[:session][:password])
      log_in(user) # sessionhelperのアクションに上記で代入したuserを入れる。
      flash[:success] = "Successfully logged in."
      redirect_to root_url
    else
      redirect_to login_url # renderでもよさそう
    end
  end

  def destroy #sessionでのdestroyはすなわちlogout
    log_out # sessionhelperで定義されている。
    flash[:success] = "Successfully logged out."
    redirect_to root_url
  end
end
