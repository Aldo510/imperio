class TrainingAttendance < ApplicationRecord
  belongs_to :athlete_card

  validates :attended_on, presence: true
end
