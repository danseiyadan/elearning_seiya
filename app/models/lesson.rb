class Lesson < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :answers
  has_one :activity, as: :action
  
  default_scope -> {order("created_at DESC")}
end
