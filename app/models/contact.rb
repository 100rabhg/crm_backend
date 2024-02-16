class Contact < ApplicationRecord
  belongs_to :customer
  has_many :interactions, dependent: :destroy

  validates :address, presence: true
  validates :phone_number, presence: true
end
