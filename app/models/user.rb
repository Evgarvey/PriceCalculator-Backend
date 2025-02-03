class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Your existing associations
  has_many :shopping_lists, dependent: :destroy
  has_many :list_items, through: :shopping_lists
end
