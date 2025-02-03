class CreateListItems < ActiveRecord::Migration[8.0]
  def change
    create_table :list_items do |t|
      t.references :list, null: false, foreign_key: true
      t.references :material, null: false, foreign_key: true
      t.decimal :quantity

      t.timestamps
    end
  end
end
