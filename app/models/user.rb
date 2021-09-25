class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :avatar, presence: true
  # 下記プロフィールの自己紹介文のため200文字までとする。
  validates :profile, length: { maximum: 200 }

  has_one_attached :avatar
  has_many_attached :images

  has_many :post_items ,dependent: :destroy
#今回は現会員＝false(db上でもdefault値をfalseにて登録)、退会ユーザー（Non_member）をtrueとしてる
   def active_for_authentication?
     super && (self.is_deleted == false)
   end

end
