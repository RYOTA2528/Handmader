class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

# 新規会員登録の際のバリデーション
   validates :name, presence: true
   validates :email, presence: true
   validates :password, presence: true, on: :create

# プロフィール用のバリデーション
  with_options on: :update do
   validates :nickname, presence: true
   validates :profile, presence: true, length: { maximum: 200 }
end

# def create?

# end

  has_one_attached :avatar
  has_one_attached :background
  has_many_attached :images

# DM機能の作成
  has_many :chats, dependent: :destroy
  has_many :entries, dependent: :destroy

  has_many :post_items, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_many :comments, dependent: :destroy
# (フォロー機能の中間テーブル)
  # following_relationshipsというフォロー用中間テーブルを介し、following_id（フォロー）を集めます。
  has_many :follower_relationships, foreign_key: "following_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :follower_relationships
  # following_relationshipsというフォロー用中間テーブルを介し、follower_id（フォローワー）を集めます。
  has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship",  dependent: :destroy
  has_many :following, through: :following_relationships

#（退会機能　条件分岐用）
#今回は現会員＝false(db上でもdefault値をfalseにて登録)、退会ユーザー（Non_member）をtrueとしてる
   def active_for_authentication?
     super && (self.is_deleted == false)
   end
# (お気に入り機能：条件分岐用)
# 投稿に対して、ファボしてるorファボしてないで条件分岐を作る
   def already_favorited?(post_item)
    self.favorites.exists?(post_item_id: post_item.id)
   end
# （フォロー機能　条件分岐）
# フォローしてるかしていないかをファボ同様に条件分岐でわけてる
   def already_following?(user)
    following_relationships.find_by(following_id: user.id)
   end

  # フォロー用メソッド
  def active_follow(user)
    following_relationships.create!(following_id: user.id)
  end

  #フォロー解除用メソッド
  def delete_follow(user)
    following_relationships.find_by(following_id: user.id).destroy
  end

#   def update_without_current_password(params, *options)
#     params.delete(:current_password)

#     if params[:password].blank? && params[:password_confirmation].blank?
#       params.delete(:password)
#       params.delete(:password_confirmation)
#     end

#     result = update_attributes(params, *options)
#     clean_up_passwords
#     result
#   end


end
