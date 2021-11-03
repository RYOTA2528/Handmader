class Public::ChatsController < ApplicationController
  before_action :authenticate_user!

  def create
    # 現ログインユーザーのform_withで渡したパラメータに情報が入ってるかの確認。
    @chat = Chat.create(user_id: current_user.id, chat: params[:chat][:chat], chat_room_id: params[:chat][:chat_room_id])
    if @chat.save
      redirect_to public_chat_room_path(@chat.chat_room_id), notice: 'メッセージが送信されました'
    else
      flash[:alert] ="メッセージが送信できませんでした"
      redirect_to public_chat_room_path(@chat.chat_room_id)
    end
  end

  private

  def chat_params
    params.require(:user).permit(:nickname,:avatar,:profile, images: [])
  end


end
