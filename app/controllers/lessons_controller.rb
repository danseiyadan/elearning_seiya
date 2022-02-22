class LessonsController < ApplicationController
  def create
    @category = Category.find(params[:category_id])
    @lesson = @category.lessons.build(lesson_params)
    @lesson.save
    redirect_to new_lesson_answer_path(@lesson.id)
  end

  def index
    @categories = Category.paginate(page: params[:page], per_page: 10)
  end

  def show
    @lesson = Lesson.find(params[:id])
    @answers = @lesson.answers.all
  end

  private
  def lesson_params
    params.permit(:category_id, :user_id)
  end
end
