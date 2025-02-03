class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Your existing associations
  has_many :shopping_lists, dependent: :destroy
  has_many :list_items, through: :shopping_lists

  validates :email, presence: true, 
                   format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, if: :password_required?

  private
  
  def password_required?
    new_record? || password.present? || password_confirmation.present?
  end
end
