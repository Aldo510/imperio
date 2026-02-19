class ResultPath < ApplicationRecord
  belongs_to :athlete_card

  enum term: { short_term: 0, medium_term: 1, long_term: 2 }

  validates :term, :goal, presence: true
  validates :term, uniqueness: { scope: :athlete_card_id }
end
