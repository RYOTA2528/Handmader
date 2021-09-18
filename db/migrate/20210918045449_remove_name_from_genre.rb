class RemoveNameFromGenre < ActiveRecord::Migration[5.2]
  def change
    remove_column :genres, :name, :string
  end
end
