class ShoppingList < ApplicationRecord
  belongs_to :user

  has_many :list_items, dependent: :destroy
  has_many :materials, through: :list_items
end
