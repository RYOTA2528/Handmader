class PostItem < ApplicationRecord
  belongs_to :user
  has_many :post_item_genres, dependent: :destroy
  has_many :genres, through: :post_item_genres

  has_many_attached :images
  has_one_attached :avatar
  validates :images, presence: { message: '画像をアップロードしてください' }
  validates :name, presence: true
  # validates :post_item_genre_ids, uniqueness: true
  # validates :genre, uniqueness: true
  validates :text, presence: true, length: { maximum: 1000 }
  belongs_to :user, optional: true
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :genres, presence: true


end
