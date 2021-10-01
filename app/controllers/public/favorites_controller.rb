class Public::FavoritesController < ApplicationController
  before_action :set_post, only: [:create, :destroy]
  before_action :authenticate_user!

  def show
    favorite_list = Favorite.where(user_id: current_user.id).pluck(:post_item_id)
    @favorite_list_page = PostItem.find(favorite_list)
  end


  # ファボする(投稿者とログイン中のユーザーが違う場合のみ可能。非同期処理により作成)
  def create
    unless @post_item.user_id == current_user.id
      @favorite = Favorite.create(user_id: current_user.id, post_item_id: @post_item.id)
      @favorite.save
      flash[:success] = "作品をお気に入りに登録しました"
    end
  end
  #　ファボを解除（上記同様、投稿者とログイン中のユーザーが違う場合のみ可能。非同期処理により作成）
  def destroy
    unless @post_item.user_id == current_user.id
      @favorite = Favorite.find_by(user_id: current_user.id, post_item_id: @post_item.id)
      @favorite.destroy
      flash[:danger] = "作品のお気に入りを解除しました"
    end
  end

  private
  # 投稿作品に対して、ファボ機能を実装するため、先に特定の投稿を見つける必要がある
  def set_post
    @post_item = PostItem.find(params[:post_item_id])
  end


end
