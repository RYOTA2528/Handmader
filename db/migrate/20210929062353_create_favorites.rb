class CreateFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites do |t|
      t.bigint :user_id, null: false
      t.bigint :post_item_id, null: false
      t.timestamps
    end
      add_foreign_key :favorites, :users, column: :user_id
      add_foreign_key :favorites, :post_items, column: :post_item_id
  end
end