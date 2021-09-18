class PostItme < ApplicationRecord
  has_many :post_item_genres
  has_many :genres, through: :post_item_genres
end
