class CreateMaterialCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :material_categories do |t|
      t.string :name
      t.string :base_unit
      t.text :description

      t.timestamps
    end
  end
end
