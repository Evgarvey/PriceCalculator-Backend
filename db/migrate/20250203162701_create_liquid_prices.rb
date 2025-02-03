class CreateLiquidPrices < ActiveRecord::Migration[8.0]
  def change
    create_table :liquid_prices do |t|
      t.references :material, null: false, foreign_key: true
      t.decimal :price_per_liter
      t.decimal :density

      t.timestamps
    end
  end
end
