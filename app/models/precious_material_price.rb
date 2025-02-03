class PreciousMaterialPrice < ApplicationRecord
  belongs_to :material
  
  validates :price_per_gram, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :density, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
end
