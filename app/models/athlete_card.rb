class AthleteCard < ApplicationRecord
  belongs_to :school

  has_one_attached :photo

  has_many :training_schedules, dependent: :destroy
  has_many :training_attendances, dependent: :destroy
  has_many :weekend_match_attendances, dependent: :destroy
  has_many :injury_reports, dependent: :destroy
  has_many :result_paths, dependent: :destroy
  has_many :technical_developments, dependent: :destroy
  has_many :tactical_developments, dependent: :destroy

  accepts_nested_attributes_for :training_schedules, allow_destroy: true
  accepts_nested_attributes_for :injury_reports, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :result_paths, allow_destroy: true, reject_if: :all_blank

  enum dominant_profile: { right: 0, left: 1 }
  enum skill_level: { novice_conscious: 0, beginner_conscious: 1, competitive_conscious: 2 }

  validates :name, :birth_date, :curp, :age, :guardian_name, :phone_number, :size, :dominant_profile, :skill_level, presence: true
  validates :curp, uniqueness: true
  validates :age, numericality: { greater_than_or_equal_to: 0 }
  validates :weight_kg, numericality: { greater_than: 0 }, allow_nil: true
  validates :height_cm, numericality: { greater_than: 0 }, allow_nil: true

  before_validation :normalize_curp
  before_validation :assign_age_from_birth_date

  private

  def normalize_curp
    self.curp = curp.to_s.upcase.strip
  end

  def assign_age_from_birth_date
    return if birth_date.blank?

    today = Date.current
    computed_age = today.year - birth_date.year
    computed_age -= 1 if today < birth_date + computed_age.years
    self.age = computed_age
  end
end
