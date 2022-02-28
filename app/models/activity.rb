class Activity < ApplicationRecord
  belongs_to :user
  belongs_to :action, polymorphic: true, optional: true

  default_scope -> {order("created_at DESC")}
end
