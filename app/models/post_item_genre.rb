class PostItemGenre < ApplicationRecord
  belongs_to :genre
  belongs_to :post_item
  has_many_attached :images
  # validates :images, presence: { message: '画像をアップロードしてください' }
   validates :post_item_id, uniqueness: true
end
