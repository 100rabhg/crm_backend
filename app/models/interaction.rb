class Interaction < ApplicationRecord
  belongs_to :contact

  validates :subject, presence: true
  validates :description, presence: true
end
