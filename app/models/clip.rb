class Clip < ApplicationRecord
  belongs_to :user
  belongs_to :flyer
  validates_uniquness_of :flyer_id, scope: user_id
end
