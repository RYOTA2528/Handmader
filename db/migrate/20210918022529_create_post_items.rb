class CreatePostItems < ActiveRecord::Migration[5.2]
  def change
    create_table :post_items do |t|
      t.bigint "genre_id", null: false
      t.bigint "user_id", null: false
      t.string "name", null: false
      t.text "text", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
        t.timestamps
      end
      add_foreign_key :post_items, :genres, column: :genre_id
      add_foreign_key :post_items, :users, column: :user_id
  end
end
