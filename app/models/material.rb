class Material < ApplicationRecord
  belongs_to :material_category

  has_many :list_items, dependent: :destroy
  has_many :shopping_lists, through: :list_items

  has_one :price, dependent: :destroy

  validates :name, presence: true
  validates :material_category, presence: true
end
