class Word < ApplicationRecord
  belongs_to :category
  has_many :choices, dependent: :destroy

  validates :content, presence: true, uniqueness: { scope: :category_id }
  accepts_nested_attributes_for :choices, allow_destroy: true
  validate :only_one_correct_answer
  validate :unique_choice

  private
  def only_one_correct_answer
    correct_answers = choices.select {|choice| choice.is_correct == true}.length
    if correct_answers != 1
      # return false
      return errors.add(:word, "should have one correct answer.")
    end
    # return true
  end

  def unique_choice
    # check_same_choices = choices.select(:content).distinct.length
    check_same_choices = choices.uniq {|choice| choice.content }.length
    if check_same_choices != 3
      return errors.add(:word, "cannot have same choices.")
    end
  end
end
