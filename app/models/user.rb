class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 告知
  has_many :flyers, dependent: :destroy
  # コメント
  has_many :comments, dependent: :destroy
  # クリップ
  has_many :clips, dependent: :destroy

  # アイコン
  has_one_attached :profile_image

  # バリデーション
  # 表示名(50文字まで)
  validates :display_name, presence: true, length: { maximum: 25 }
  # URL
  # validates :url, format: /\A#{URI::regexp(%w(http https))}\z/

  # アイコン用の画像
  def get_profile_image
    (profile_image.attached?) ? profile_image: 'no_image.jpg'
  end
end
