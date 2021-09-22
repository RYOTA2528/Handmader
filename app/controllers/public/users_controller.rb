class Public::UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    # PostImageモデル作成後の記述。下記のようにすると現在のユーザーの投稿のみを取得できる
    # @post_items = @user.post_items.page(params[:page]).reverse_order
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

  def user_params
   params.require(:user).permit(:nickname,:avatar,:profile)
  end

end
