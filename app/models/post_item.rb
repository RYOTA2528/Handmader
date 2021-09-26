class PostItem < ApplicationRecord
  belongs_to :user
  has_many :post_item_genres
  has_many :genres, through: :post_item_genres

  has_many_attached :images
  has_one_attached :avatar
  # 下記プロフィールの自己紹介文のため200文字までとする。
  validates :text, length: { maximum: 1000 }
  
  
end
