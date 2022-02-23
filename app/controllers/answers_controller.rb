class AnswersController < ApplicationController
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
      redirect_to @lesson
    end
  end

  private
  def answer_params
    params.permit(:choice_id, :word_id, :lesson_id)
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
end
