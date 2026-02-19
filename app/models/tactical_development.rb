class TacticalDevelopment < ApplicationRecord
  SKILL_FIELDS = %i[
    game_vision
    positioning_by_role
    mental_anticipation
    environment_adaptation
    counteracts_opponent_actions
    applies_offensive_tactical_fundamentals
    applies_defensive_tactical_fundamentals
    match_interval_management
    initiative_decision_making
    improvises_under_unexpected_situation
    communication_during_match
  ].freeze

  RATING_SCALE = { insufficient: 0, regular: 1, good: 2 }.freeze

  belongs_to :athlete_card
  belongs_to :team
  belongs_to :category

  enum :game_vision, RATING_SCALE, prefix: true
  enum :positioning_by_role, RATING_SCALE, prefix: true
  enum :mental_anticipation, RATING_SCALE, prefix: true
  enum :environment_adaptation, RATING_SCALE, prefix: true
  enum :counteracts_opponent_actions, RATING_SCALE, prefix: true
  enum :applies_offensive_tactical_fundamentals, RATING_SCALE, prefix: true
  enum :applies_defensive_tactical_fundamentals, RATING_SCALE, prefix: true
  enum :match_interval_management, RATING_SCALE, prefix: true
  enum :initiative_decision_making, RATING_SCALE, prefix: true
  enum :improvises_under_unexpected_situation, RATING_SCALE, prefix: true
  enum :communication_during_match, RATING_SCALE, prefix: true

  validates :evaluated_on, presence: true
  validate :team_category_match

  def score_for(field)
    value = public_send(field)
    self.class.defined_enums[field.to_s][value].to_i
  end

  def overall_score
    total = SKILL_FIELDS.sum { |field| score_for(field) }
    total.to_f / SKILL_FIELDS.size
  end

  private

  def team_category_match
    return if team.blank? || category.blank?
    return if team.category_id == category_id

    errors.add(:category_id, "debe coincidir con la categoría del equipo")
  end
end
