class CreateEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :entries do |t|
      t.integer "user_id", null: false
      t.integer "chat_room_id", null: false
      t.timestamps
    end
      add_foreign_key :entries, :users, column: :user_id
      add_foreign_key :entries, :chat_rooms, column: :chat_room_id
  end
end
