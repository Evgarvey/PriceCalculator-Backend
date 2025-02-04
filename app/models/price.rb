class Price < ApplicationRecord
  belongs_to :material
  validates :price_per_unit, presence: true, numericality: { greater_than_or_equal_to: 0 }
end 