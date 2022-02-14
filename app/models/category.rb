class Category < ApplicationRecord
  default_scope -> {order("created_at DESC")}
  
  validates :title, presence: true, length: { maximum: 50 }, uniqueness: true
  validates :description, presence: true, length: { maximum: 100 }
end
