class RemoveGenreIdFromPostItem < ActiveRecord::Migration[5.2]
  def change
    remove_column :post_items, :genre_id, :integer
  end
end
