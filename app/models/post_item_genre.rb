class PostItemGenre < ApplicationRecord
  belongs_to :genre, dependent: :destroy
  belongs_to :post_item, dependent: :destroy
  has_many_attached :images
  # validates :images, presence: { message: '画像をアップロードしてください' }
   validates :post_item_id, uniqueness: true
end
