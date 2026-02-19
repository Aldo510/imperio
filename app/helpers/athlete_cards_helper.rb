module AthleteCardsHelper
  TRAINING_DAY_LABELS = {
    "monday" => "Lunes",
    "tuesday" => "Martes",
    "wednesday" => "Miércoles",
    "thursday" => "Jueves",
    "friday" => "Viernes"
  }.freeze

  RESULT_TERM_LABELS = {
    "short_term" => "Corto plazo (1-3 meses)",
    "medium_term" => "Mediano plazo (3-6 meses)",
    "long_term" => "Largo plazo (6-12 meses)"
  }.freeze

  SKILL_LEVEL_LABELS = {
    "novice_conscious" => "A - Novato consciente",
    "beginner_conscious" => "B - Principiante consciente",
    "competitive_conscious" => "C - Competitivo consciente"
  }.freeze

  DOMINANT_PROFILE_LABELS = {
    "right" => "Derecho",
    "left" => "Izquierdo"
  }.freeze

  WEEKEND_DAY_LABELS = {
    "saturday" => "Sábado",
    "sunday" => "Domingo"
  }.freeze

  def training_day_label(day)
    TRAINING_DAY_LABELS[day.to_s] || day.to_s.humanize
  end

  def result_term_label(term)
    RESULT_TERM_LABELS[term.to_s] || term.to_s.humanize
  end

  def skill_level_label(level)
    SKILL_LEVEL_LABELS[level.to_s] || level.to_s.humanize
  end

  def dominant_profile_label(profile)
    DOMINANT_PROFILE_LABELS[profile.to_s] || profile.to_s.humanize
  end

  def weekend_day_label(day)
    WEEKEND_DAY_LABELS[day.to_s] || day.to_s.humanize
  end
end
