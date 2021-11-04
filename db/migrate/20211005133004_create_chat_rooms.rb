class CreateChatRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :chat_rooms do |t|
      t.bigint "user_id", null: false
      t.timestamps
    end
     add_foreign_key :chat_rooms, :users, column: :user_id
  end
end
