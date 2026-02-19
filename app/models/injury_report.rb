class InjuryReport < ApplicationRecord
  belongs_to :athlete_card

  validates :injury_name, presence: true
end
