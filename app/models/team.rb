class Team < ApplicationRecord
  belongs_to :category
  has_one_attached :logo
  has_many :players, dependent: :destroy
  has_many :matches_as_home, class_name: 'Match', foreign_key: 'home_team_id', dependent: :destroy
  has_many :matches_as_away, class_name: 'Match', foreign_key: 'away_team_id', dependent: :destroy
  has_many :scores

  after_initialize :set_default_stats

  private

  def set_default_stats
    self.points ||= 0
    self.wins ||= 0
    self.draws ||= 0
    self.losses ||= 0
    self.shotout_wins ||= 0
    self.shotout_losses ||= 0
  end
  
end

