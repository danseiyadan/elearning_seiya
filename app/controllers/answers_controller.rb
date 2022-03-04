class AnswersController < ApplicationController
  before_action :only_loggedin_users
  before_action :prohibit_lesson_retake
  before_action :different_user_lesson

  def new 
    @lesson = Lesson.find(params[:lesson_id])
    @answer = @lesson.answers.build
    @words = @lesson.category.words.paginate(page: params[:page], per_page: 1)
  end

  def create
    @lesson = Lesson.find(params[:lesson_id])
    @answer = @lesson.answers.build(answer_params)
    @answer.save
    unless params[:page].nil?
      redirect_to new_lesson_answer_path(@lesson.id, page: params[:page])
    else
      @lesson.update(result: check_results)
      @lesson.create_activity!(activity_params)
      redirect_to @lesson
    end
  end

  private
  def answer_params
    params.permit(:choice_id, :word_id, :lesson_id)
  end

  def activity_params
    params.permit(:user_id)
  end

  def check_results
    @lesson = Lesson.find(params[:lesson_id])
    @answers = @lesson.answers.all
    result = 0
    @answers.each do |answer|
      if answer.choice_id == answer.word.choices.find_by(is_correct: true).id
        result += 1
      end
    end
    return result
  end

  def prohibit_lesson_retake
    lesson = Lesson.find(params[:lesson_id])
    unless lesson.result.nil?
      flash[:danger] = "Invalid action"
      redirect_to lessons_path
    end
  end

  def different_user_lesson
    lesson = Lesson.find(params[:lesson_id])
    if lesson.user != current_user
      flash[:danger] = "Invalid action"
      redirect_to lessons_path
    end
  end
end
