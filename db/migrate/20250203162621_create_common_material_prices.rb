class CreateCommonMaterialPrices < ActiveRecord::Migration[8.0]
  def change
    create_table :common_material_prices do |t|
      t.references :material, null: false, foreign_key: true
      t.decimal :price_per_m3
      t.decimal :density

      t.timestamps
    end
  end
end
