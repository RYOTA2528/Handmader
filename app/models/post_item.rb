class PostItem < ApplicationRecord
  belongs_to :user
  has_many :post_item_genres
  has_many :genres, through: :post_item_genres

  has_many_attached :images
  #投稿作品の画像
  # validates :image, presence: true
  # 下記プロフィールの自己紹介文のため200文字までとする。
  validates :text, length: { maximum: 1000 }
end
