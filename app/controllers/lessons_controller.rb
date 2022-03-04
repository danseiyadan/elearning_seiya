class LessonsController < ApplicationController
  before_action :invalid_lesson, only: :show
  before_action :only_loggedin_users

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

  def invalid_lesson
    @lesson = Lesson.find(params[:id])
    if @lesson.result.nil? || @lesson.user_id != current_user.id
      flash[:danger] = "Invalid action"
      redirect_to lessons_path
    end
  end
end
