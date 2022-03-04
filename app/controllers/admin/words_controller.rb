class Admin::WordsController < ApplicationController
  before_action :admin_login

  def new
    @category = Category.find(params[:category_id])
    @word = @category.words.build
    3.times do 
      @choice = @word.choices.build
    end
  end

  def create
    @category = Category.find(params[:category_id])
    @word = @category.words.build(word_params)
    if @word.save
      flash[:success] = "New word added"
      redirect_to admin_category_path(@category.id)
    else
      render "new"
    end
  end
  
  def edit
    @category = Category.find(params[:category_id])
    @word = @category.words.find(params[:id])
  end

  def update
    @category = Category.find(params[:category_id])
    @word = @category.words.find(params[:id])
    if @word.update(word_params)
      flash[:success] = "Word updated"
      redirect_to admin_category_path(@category.id)
    else
      render "edit"
    end
  end

  def destroy
    @category = Category.find(params[:category_id])
    @category.words.find(params[:id]).destroy
    redirect_to admin_category_path(@category.id)
  end

  private
  def word_params
    params.require(:word).permit(:content, choices_attributes: [:content, :is_correct, :_destroy, :id])
  end
end
