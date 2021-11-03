class PostItem < ApplicationRecord
  belongs_to :user
  has_many :post_item_genres, dependent: :destroy
  has_many :genres, through: :post_item_genres

  has_many_attached :images
  has_one_attached :avatar
  validates :images, presence: { message: '画像をアップロードしてください' }
  validates :name, presence: true
  validates :text, presence: true, length: { maximum: 1000 }


  belongs_to :user, optional: true
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

# 投稿編集ページ内で画像自体の、”全消し”ができないようにするために定義
  def same_amount_images?(images)
    if images.present?
      self.images.length == images.length
    else
      false
    end
  end




end
