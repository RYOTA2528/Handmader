class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :post_item

  # 一意性にします（userの同じ投稿に対して、何度もお気に入り登録できないようにするために設定）
  validates_uniqueness_of :post_item_id, scope: :user_id
end
