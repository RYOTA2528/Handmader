class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post_item
  has_one_attached :avatar
  # コメント空送信を防ぐため
  validates :content, presence: true
  # 文字数カウント300文字までとする
  validates :content, length: { maximum: 300 }

end
