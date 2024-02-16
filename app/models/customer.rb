class Customer < ApplicationRecord
    has_many :contacts, dependent: :destroy

    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
end
  