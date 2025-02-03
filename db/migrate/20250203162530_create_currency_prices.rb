class CreateCurrencyPrices < ActiveRecord::Migration[8.0]
  def change
    create_table :currency_prices do |t|
      t.references :material, null: false, foreign_key: true
      t.decimal :usd_ratio

      t.timestamps
    end
  end
end
