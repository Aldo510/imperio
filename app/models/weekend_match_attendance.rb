class WeekendMatchAttendance < ApplicationRecord
  belongs_to :athlete_card

  enum weekend_day: { saturday: 0, sunday: 1 }

  validates :match_date, :weekend_day, presence: true
  validate :date_must_match_selected_weekend_day

  private

  def date_must_match_selected_weekend_day
    return if match_date.blank? || weekend_day.blank?

    expected = saturday? ? 6 : 0
    return if match_date.wday == expected

    errors.add(:match_date, "no coincide con el día de fin de semana seleccionado")
  end
end
