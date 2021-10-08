class Public::ChatRoomsController < ApplicationController
  def create
    @chat_room = ChatRoom.create
    # ログイン中の現ユーザーのエントリー情報を保存
    @current_user_entry = Entry.create(chat_room_id: @chat_room.id, user_id: current_user.id)
    # 招待を受ける側(フォローされてる側)ユーザーのエントリーを保存。
    @recive_user_entry = Entry.create(chat_room_id: @chat_room.id, user_id: params[:user_id])
    redirect_to public_chat_room_path(@chat_room)
  end

  def show
    @chat_room = ChatRoom.find(params[:id])
    # createで保存したEntryから現ログインユーザーとそれに紐づく@chat_room.idを探し、そのレコードがあればメッセージの表示&新規メッセージ作成
    if Entry.where(user_id: current_user.id, chat_room_id: @chat_room.id ).present?
      @chats = @chat_room.chats
      @chat = Chat.new
      @users = User.joins(:entries).where(entries: {chat_room_id: @chat_room.id})
      # レコードが見つからなかった場合は、一度チャット前ページへ戻ります
    else
      redirect_back(fallback_location: public_user_path(@user))
    end
  end

  private

  def entry_params
   params.require(:entry).permit(:user_id)
  end

end

