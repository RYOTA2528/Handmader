class Genre < ApplicationRecord
  has_many :post_item_genres, dependent: :destroy
  has_many :post_items, through: :post_item_genres
  validates :name, presence: true
  has_one_attached :image
  # ActiveRecord用のvalidation
 validates :image, presence: { message: '画像をアップロードしてください' }

end