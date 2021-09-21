class ChangeColumnToNull < ActiveRecord::Migration[5.2]
  def up
    change_column :users, :nickname,:string, null: true
  end
  def down
    change_column :users, :nickname,:string, null: false
  end
end
