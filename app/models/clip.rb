class Clip < ApplicationRecord
  belongs_to :user
  belongs_to :flyer
  validates_uniqueness_of :flyer_id, scope: :user_id
end
