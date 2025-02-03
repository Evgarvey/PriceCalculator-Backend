class ListItem < ApplicationRecord
  belongs_to :list
  belongs_to :material
end
