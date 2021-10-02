class Relationship < ApplicationRecord
  # 外部キー（following_id）に属している
  belongs_to :following, class_name: "User"
  # 外部キー（follower_id）に属している
  belongs_to :follower, class_name: "User"

  validates :following_id, presence: true
  validates :follower_id, presence: true
end
