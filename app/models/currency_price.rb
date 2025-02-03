class CurrencyPrice < ApplicationRecord
  belongs_to :material
  
  validates :usd_ratio, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
end
