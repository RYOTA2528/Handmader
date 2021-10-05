class CreateChats < ActiveRecord::Migration[5.2]
  def change
    create_table :chats do |t|
      t.integer "user_id", null: false
      t.integer "chat_room_id", null: false
      t.text "chat", null: false
      t.timestamps
    end
      add_foreign_key :chats, :users, column: :user_id
      add_foreign_key :chats, :chat_rooms, column: :chat_room_id
  end
end
