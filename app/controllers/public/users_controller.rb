class Public::UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @post_items = @user.post_items
    @comments =Comment.all
    # PostImageモデル作成後の記述。下記で現在のユーザーの投稿のみを取得できる
    @post_items = @user.post_items.page(params[:page]).reverse_order
#フォロー・フォロワーどうしは使用可能なチャット機能を作成。下記にコードを記述
# 現在のユーザーのルームIDと招待を受ける側ユーザーのチャットルームIDが一緒ならば既に作成済みルームを選び。falseならチャットルーム・Entryの新規作成を。
    @currentUserEntry = Entry.where(user_id: current_user.id)
    @reciveUserEntry = Entry.where(user_id: @user.id)
    @haveChatRoom = false
    # 前提として、@user.idはcurrent_user.idではない（一意性）
    unless @user.id == current_user.id
      @currentUserEntry.each do |cu|
         @reciveUserEntry.each do |ru|
           if cu.chat_room_id == ru.chat_room_id then
             @haveChatRoom = true
             @chat_room_id = cu.chat_room_id
           end
         end
      end
    end
    unless @haveChatRoom
        @chat_room = ChatRoom.new
        @entry = Entry.new
    end
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
# 退会機能用メソッド
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
#フォロー機能用（一覧ページ用）メソッド
  #（フォロー一覧）
  def following
   @user = User.find(params[:id])
   @followings = @user.following
  end

  #（フォロワー一覧）
  def followers
   @user = User.find(params[:id])
   @followers = @user.followers
  end

  private

  def user_params
   params.require(:user).permit(:nickname,:avatar,:profile, images: [])
  end

end
