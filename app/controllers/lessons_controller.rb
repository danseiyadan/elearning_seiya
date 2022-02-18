class LessonsController < ApplicationController
  def create
    @category = Category.find(params[:category_id])
    @lesson = @category.lessons.build(lesson_params)
    @lesson.save
    redirect_to @lesson # just for now
  end

  def update
    
  end

  def index
    @categories = Category.paginate(page: params[:page], per_page: 10)
  end

  def show
    @lesson = Lesson.find(params[:id])
  end

  private
  def lesson_params
    params.permit(:result, :category_id, :user_id)
  end
end
