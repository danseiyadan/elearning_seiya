class Admin::CategoriesController < ApplicationController
  before_action :admin_login

  def new
    @category = Category.new
  end
  
  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "New lesson added!"
      redirect_to admin_categories_path
    else
      render "new"
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      flash[:success] = "Lesson information updated!"
      redirect_to admin_categories_path
    else
      render "edit"
    end
  end

  def index
    @categories = Category.paginate(page: params[:page], per_page: 10)
  end

  def show
    @category = Category.find(params[:id])
    @words = @category.words.paginate(page: params[:page], per_page: 5)
  end

  def destroy
    Category.find(params[:id]).destroy
    redirect_to admin_categories_path
  end

  private
  def category_params
    params.require(:category).permit(:title, :description)
  end
end
