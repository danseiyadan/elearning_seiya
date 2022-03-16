class UsersController < ApplicationController
  before_action :correct_user, only: [:edit, :destroy]
  before_action :only_correct_user, only: [:learnt, :not_learnt]
  before_action :only_loggedin_users, only: [:index, :show, :edit, :update, :destroy, :following, :followers, :learnt, :not_learnt]
  before_action :already_loggedin, only: :new

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Account successfully created"
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
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render "edit"
    end
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end

  def show
    @user = User.find(params[:id])
    @lessons = @user.lessons.where("result IS NOT NULL").paginate(page: params[:page], per_page: 10)
  end  

  def destroy
    User.find(params[:id]).destroy
    redirect_to users_path
  end

  def following
    @title = "Following users"
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page], per_page: 5)
    render "show_follow"
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page], per_page: 5)
    render "show_follow"
  end

  # the 2 actions below are to display learnt and not learnt lessons
  def learnt
    @title = "Learnt lessons"
    @user = User.find(params[:id])
    @categories = Category.select { |category| category.lessons.where("user_id = ?", @user.id).where("result IS NOT NULL").any?  }.paginate(page: params[:page], per_page: 10)
    render "lessons/filtered_lessons"
  end

  def not_learnt
    @title = "Not learnt lessons"
    @user = User.find(params[:id])
    @categories = Category.all.reject { |category| category.lessons.where("user_id = ?", @user.id).where("result IS NOT NULL").any?  }.paginate(page: params[:page], per_page: 10)
    render "lessons/filtered_lessons"
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def correct_user 
    user = User.find(params[:id])
    unless user == current_user || admin_user?
      flash[:danger] = "You are not authorized"
      redirect_back fallback_location: root_path
    end
  end

  def only_correct_user
    user = User.find(params[:id])
    unless user == current_user
      flash[:danger] = "You are not authorized"
      redirect_back fallback_location: root_path
    end
  end
end
