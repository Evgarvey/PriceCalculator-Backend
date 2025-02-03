class MaterialCategory < ApplicationRecord
  has_many :materials, dependent: :destroy
  has_many :list_items, through: :materials, dependent: :destroy
  has_many :common_material_prices, through: :materials, dependent: :destroy
  has_many :precious_material_prices, through: :materials, dependent: :destroy
  has_many :liquid_prices, through: :materials, dependent: :destroy
  has_many :currency_prices, through: :materials, dependent: :destroy
  
  validates :name, presence: true, uniqueness: true
  validates :base_unit, presence: true
end
