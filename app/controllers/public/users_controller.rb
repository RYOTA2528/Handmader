class Public::UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @post_items = @user.post_items
    # 現在のユーザーがお気に入りにしたpost_item_idを全件取得し格納
    # favorite_list = Favorite.where(user_id: current_user.id).pluck(:post_item.id)
    # ↑で格納したお気に入りリスト（お気に入りにした投稿レコードを取得したもの）を、マイページで一覧として出力できるよう変数定義(@favorite.list_page)しview側でeach文で出力
    # @favorite_list_page = PostItem.find(favorite_list)
    # PostImageモデル作成後の記述。下記で現在のユーザーの投稿のみを取得できる
    @post_items = @user.post_items.page(params[:page]).reverse_order
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(user_params)
      redirect_to public_user_path(@user.id)
      flash[:notice]='プロフィールが登録されました。'
    else
      render :edit
    end
  end

  def unsubscribe
   @user = current_user
  end

  def withdraw
   @user = current_user
   @user.update(is_deleted: true)
   # true＝退会ユーザーです。
   reset_session
   flash[:notice] = "ありがとうございました。またのご利用お待ちしております！"
   redirect_to root_path
  end

  private

  def user_params
   params.require(:user).permit(:nickname,:avatar,:profile, images: [])
  end

end
