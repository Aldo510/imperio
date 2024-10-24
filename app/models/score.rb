class Score < ApplicationRecord
  belongs_to :match
  belongs_to :winner, class_name: 'Team', optional: true
  belongs_to :loser, class_name: 'Team', optional: true
  has_many :goal_scorers, class_name: 'Player'
end
