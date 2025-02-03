class FixListItemsReferences < ActiveRecord::Migration[8.0]
  def up
    # Create temporary table with correct structure
    create_table :temp_list_items do |t|
      t.integer :shopping_list_id, null: false
      t.integer :material_id, null: false
      t.decimal :quantity
      t.timestamps
    end

    # Copy data if old table exists
    if table_exists?(:list_items)
      execute <<-SQL
        INSERT INTO temp_list_items (shopping_list_id, material_id, quantity, created_at, updated_at)
        SELECT list_id, material_id, quantity, created_at, updated_at
        FROM list_items
      SQL
      
      # Drop old table
      drop_table :list_items
    end

    # Rename temporary table to final name
    rename_table :temp_list_items, :list_items

    # Add indexes and foreign keys
    add_index :list_items, :shopping_list_id
    add_index :list_items, :material_id
    add_foreign_key :list_items, :shopping_lists
    add_foreign_key :list_items, :materials
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end 