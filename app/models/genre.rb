class Genre < ApplicationRecord
  has_many :post_item_genres
  has_many :post_items, through: :post_item_genres
  validates :name, presence: true
  validates :image, presence: true
  has_one_attached :image
end
