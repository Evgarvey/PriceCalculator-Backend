class ListItem < ApplicationRecord
  belongs_to :shopping_list
  belongs_to :material
  
  validates :shopping_list, presence: true
  validates :material, presence: true
  validates :quantity, presence: true, 
                      numericality: { 
                        only_integer: true,
                        greater_than: 0,
                        message: "should be an integer"
                      }

  validate :ensure_quantity_is_integer

  private

  def ensure_quantity_is_integer
    if quantity.present? && !quantity.to_i.to_s.to_f.to_s == quantity.to_f.to_s
      errors.add(:quantity, "should be an integer")
    end
  end
end
