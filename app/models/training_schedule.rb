class TrainingSchedule < ApplicationRecord
  belongs_to :athlete_card

  enum day_of_week: {
    monday: 0,
    tuesday: 1,
    wednesday: 2,
    thursday: 3,
    friday: 4
  }

  validates :day_of_week, :start_time, :end_time, presence: true
  validates :day_of_week, uniqueness: { scope: :athlete_card_id }
  validate :end_time_after_start_time

  private

  def end_time_after_start_time
    return if start_time.blank? || end_time.blank?
    return if end_time > start_time

    errors.add(:end_time, "debe ser mayor que la hora de inicio")
  end
end
