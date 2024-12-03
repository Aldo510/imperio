class Match < ApplicationRecord
  belongs_to :home_team, class_name: 'Team'
  belongs_to :away_team, class_name: 'Team'
  belongs_to :season

  has_one :score, dependent: :destroy
  accepts_nested_attributes_for :score

  # Enum for shotout winner
  enum shoutout_winner: { home_team: 0, away_team: 1 }, _prefix: :shoutout

  validates :date, presence: true

  after_initialize :set_default_registered
  after_update :assign_points

  private

  def set_default_registered
    self.registered ||= false
  end

  def assign_points
    if shotout?
      case shoutout_winner
      when 'home_team'
        home_team.increment!(:points, 2)
        home_team.increment!(:shotout_wins)
        away_team.increment!(:points, 1)
        away_team.increment!(:shotout_losses)
      when 'away_team'
        away_team.increment!(:points, 2)
        away_team.increment!(:shotout_wins)
        home_team.increment!(:points, 1)
        home_team.increment!(:shotout_losses)
      end
    else
      if score.home_score > score.away_score
        home_team.increment!(:points, 3)
        home_team.increment!(:wins)
        away_team.increment!(:losses)
      elsif score.away_score > score.home_score
        away_team.increment!(:points, 3)
        away_team.increment!(:wins)
        home_team.increment!(:losses)
      else
        home_team.increment!(:draws)
        away_team.increment!(:draws)
      end
    end

    self.update_column(:registered, true) # Marca el partido como registrado después de asignar puntos
  end
end
