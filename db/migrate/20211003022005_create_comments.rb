class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer :user_id, null: false
      t.integer :post_item_id, null: false
      t.text :content, null: false
      t.timestamps null: false
    end
      add_foreign_key :comments, :users, column: :user_id
      add_foreign_key :comments, :post_items, column: :post_item_id
  end
end
