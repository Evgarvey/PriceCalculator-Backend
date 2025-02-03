class Material < ApplicationRecord
  belongs_to :material_category

  has_many :list_items
  has_many :shopping_lists, through: :list_items

  has_one :currency_price
  has_one :common_material_price
  has_one :liquid_price
  has_one :precious_material_price
end
