class PostItemGenre < ApplicationRecord
  belongs_to :genre
  belongs_to :post_item, dependent: :destroy
  has_many_attached :images

  # validates :post_item_id, uniqueness: true
end
