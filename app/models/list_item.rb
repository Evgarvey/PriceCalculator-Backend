class ListItem < ApplicationRecord
  belongs_to :list, class_name: 'ShoppingList'
  belongs_to :material
end
