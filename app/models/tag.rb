class Tag < ApplicationRecord
  has_many :flyer_tags, dependent: :destroy, foreign_key: "tag_id"
  has_many :flyers, through: :flyer_tags

  scope :merge_flyer, -> (tags) { }
end
