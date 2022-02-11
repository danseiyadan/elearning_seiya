class UsersController < ApplicationController
  # before_action :logged_in_user, except: [:new, :create]
  # only_loggedin_usersと機能がかぶっているからいらないはず。
  before_action :correct_user, only: [:edit, :destroy]
  # destroyも普通は入れる。入ってないから今は消せる。
  before_action :only_loggedin_users, only: [:index, :show, :edit, :update, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Account successfully created!"
      redirect_to root_url
    else
      render "new"
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Your profile has been updated."
      redirect_to @user
    else
      render "edit"
    end
  end

  def index
    # @users = User.all
    @users = User.paginate(page: params[:page], per_page: 10)
  end

  def show
    @user = User.find(params[:id])
  end  

  def destroy
    User.find(params[:id]).destroy
    redirect_to users_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def correct_user 
    user = User.find(params[:id]) #editページに行く際に使われるから、そのページのid情報を参照する。
    if user != current_user # ビューで使わないから@は付ける必要がないみたい。
      flash[:danger] = "You are not authorized."
      redirect_back fallback_location: root_path
    end
  end

  def only_loggedin_users
    unless logged_in?
      flash[:danger] = "Please login first."
      redirect_to login_url
    end
  end
end
