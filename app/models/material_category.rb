class MaterialCategory < ApplicationRecord
  has_many :materials, dependent: :destroy
  has_many :list_items, through: :materials, dependent: :destroy
  has_many :prices, through: :materials, dependent: :destroy
  
  validates :name, presence: true, uniqueness: true
  validates :base_unit, presence: true
end
