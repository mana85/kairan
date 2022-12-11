class Flyer < ApplicationRecord
  # 告知用の画像（:imageメインイメージ、:bannerバナー）
  has_one_attached :image
  has_one_attached :banner
  # ユーザー
  belongs_to :user
  # コメント
  has_many :comments, dependent: :destroy
  # クリップ
  has_many :clips, dependent: :destroy
  # タグ
  has_many :flyer_tags, dependent: :destroy
  has_many :tags, through: :flyer_tags
  #
  # バリデーション
  validates :title, presence: true
  validates :body, presence: true
  validates :url, format: /\A#{URI::regexp(%w(http https))}\z/

  # クリップ取得
  def cliped_by?(user)
    clips.where(user_id: user.id).exists?
  end
  # タグの保存
  def save_tags(saveflyer_tags)
    # 現在のタグ
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    # 今持ってるタグと今回保存されたものの差をすでにあるタグとして古いタグは消す
    old_tags = current_tags - saveflyer_tags
    # 今回保存さえれたものと現在のさを新しいタグとして新しいタグは保存
    new_tags = saveflyer_tags - current_tags
    # 古いタグを消す
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(tag_name: old_name)
    end
    # 新しいタグを保存する
    new_tags.each do |new_name|
      flyer_tag = Tag.find_or_create_by(tag_name: new_name)
      self.tags << flyer_tag
    end
  end
end
