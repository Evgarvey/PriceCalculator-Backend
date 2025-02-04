class CreatePrices < ActiveRecord::Migration[8.0]
  def change
    create_table :prices do |t|
      t.references :material, null: false, foreign_key: true
      t.decimal :price_per_unit, precision: 20, scale: 6
      t.decimal :density, precision: 10, scale: 4
      t.timestamps
    end
  end
end 