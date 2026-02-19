class School < ApplicationRecord
  has_many_attached :images
  has_many :athlete_cards, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true
  validates :monthly_fee, numericality: { greater_than_or_equal_to: 0 }
end
  
