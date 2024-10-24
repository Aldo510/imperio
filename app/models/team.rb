class Team < ApplicationRecord
  belongs_to :category
  has_one_attached :logo
  has_many :players, dependent: :destroy
  has_many :matches_as_home, class_name: 'Match', foreign_key: 'home_team_id'
  has_many :matches_as_away, class_name: 'Match', foreign_key: 'away_team_id'
  has_many :scores
end
