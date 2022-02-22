class AnswersController < ApplicationController
  def new 
    @lesson = Lesson.find_by(params[:lesson_id])
    @answer = @lesson.answers.build
    @words = @lesson.category.words.paginate(page: params[:page], per_page: 1)
  end

  def create
    @lesson = Lesson.find_by(params[:lesson_id])
    @answer = @lesson.answers.build(answer_params)
    abort
    if @answer.save
      redirect_to @lesson
    else
      redirect_to lessons_path
    end
  end

  private
  def answer_params
    params.permit(:choice_id, :word_id, :lesson_id)
  end
end
