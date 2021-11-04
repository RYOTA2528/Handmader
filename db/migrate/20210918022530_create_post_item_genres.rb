class CreatePostItemGenres < ActiveRecord::Migration[5.2]
  def change
    create_table :post_item_genres do |t|
      t.bigint :genre_id, null: false
      t.bigint :post_item_id, null: false
      t.timestamps null: false
    end
      add_foreign_key :post_item_genres, :genres, column: :genre_id
      add_foreign_key :post_item_genres, :post_items, column: :post_item_id
  end
end
