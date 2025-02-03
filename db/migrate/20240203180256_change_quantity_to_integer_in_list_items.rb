class ChangeQuantityToIntegerInListItems < ActiveRecord::Migration[8.0]
  def up
    change_column :list_items, :quantity, :integer
  end

  def down
    change_column :list_items, :quantity, :decimal
  end
end 