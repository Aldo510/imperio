class TechnicalDevelopment < ApplicationRecord
  SKILL_FIELDS = %i[
    conduction
    reception
    passing
    finishing
    dribbling
    throw_in
    heading
    dispossession
    shielding
    sliding_tackle
  ].freeze

  RATING_SCALE = { insufficient: 0, regular: 1, good: 2 }.freeze

  belongs_to :athlete_card
  belongs_to :team
  belongs_to :category

  enum :conduction, RATING_SCALE, prefix: true
  enum :reception, RATING_SCALE, prefix: true
  enum :passing, RATING_SCALE, prefix: true
  enum :finishing, RATING_SCALE, prefix: true
  enum :dribbling, RATING_SCALE, prefix: true
  enum :throw_in, RATING_SCALE, prefix: true
  enum :heading, RATING_SCALE, prefix: true
  enum :dispossession, RATING_SCALE, prefix: true
  enum :shielding, RATING_SCALE, prefix: true
  enum :sliding_tackle, RATING_SCALE, prefix: true

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
