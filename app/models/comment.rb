class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :flyer

  validates :comment, presence: true
end
