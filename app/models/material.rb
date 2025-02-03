class Material < ApplicationRecord
  belongs_to :material_category

  has_many :list_items, dependent: :destroy
  has_many :shopping_lists, through: :list_items

  has_one :common_material_price, dependent: :destroy
  has_one :precious_material_price, dependent: :destroy
  has_one :liquid_price, dependent: :destroy
  has_one :currency_price, dependent: :destroy

  validates :name, presence: true
  validates :material_category, presence: true
end
