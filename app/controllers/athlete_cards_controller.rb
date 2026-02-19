class AthleteCardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_school
  before_action :set_athlete_card, only: %i[show edit update destroy]

  def index
    @athlete_cards = @school.athlete_cards.order(:name)
  end

  def show
    @training_attendances = @athlete_card.training_attendances.order(attended_on: :desc).limit(12)
    @weekend_match_attendances = @athlete_card.weekend_match_attendances.order(match_date: :desc).limit(12)
  end

  def new
    @athlete_card = @school.athlete_cards.new
    build_default_nested_records
  end

  def edit
    build_default_nested_records
  end

  def create
    @athlete_card = @school.athlete_cards.new(athlete_card_params)

    if @athlete_card.save
      redirect_to school_athlete_card_path(@school, @athlete_card), notice: "Cartilla creada con éxito."
    else
      build_default_nested_records
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @athlete_card.update(athlete_card_params)
      redirect_to school_athlete_card_path(@school, @athlete_card), notice: "Cartilla actualizada con éxito."
    else
      build_default_nested_records
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @athlete_card.destroy
    redirect_to school_athlete_cards_path(@school), notice: "Cartilla eliminada con éxito."
  end

  private

  def set_school
    @school = School.find(params[:school_id])
  end

  def set_athlete_card
    @athlete_card = @school.athlete_cards.find(params[:id])
  end

  def athlete_card_params
    permitted = params.require(:athlete_card).permit(
      :name,
      :birth_date,
      :curp,
      :guardian_name,
      :phone_number,
      :size,
      :weight_kg,
      :height_cm,
      :dominant_profile,
      :skill_level,
      :photo,
      training_schedules_attributes: %i[id day_of_week start_time end_time _destroy],
      injury_reports_attributes: %i[id injury_name observations reported_on _destroy],
      result_paths_attributes: %i[id term goal notes _destroy]
    )

    sanitize_training_schedules_attributes!(permitted)
    permitted
  end

  def build_default_nested_records
    build_default_training_schedules
    build_default_result_paths
    @athlete_card.injury_reports.build if @athlete_card.injury_reports.empty?
  end

  def build_default_training_schedules
    existing_days = @athlete_card.training_schedules.map(&:day_of_week)

    TrainingSchedule.day_of_weeks.keys.each do |day|
      next if existing_days.include?(day)

      @athlete_card.training_schedules.build(day_of_week: day)
    end
  end

  def build_default_result_paths
    existing_terms = @athlete_card.result_paths.map(&:term)

    ResultPath.terms.keys.each do |term|
      next if existing_terms.include?(term)

      @athlete_card.result_paths.build(term: term)
    end
  end

  def sanitize_training_schedules_attributes!(permitted)
    schedules = permitted[:training_schedules_attributes]
    return if schedules.blank?

    schedules.each do |_, attrs|
      has_id = attrs[:id].present?
      has_start_time = attrs[:start_time].present?
      has_end_time = attrs[:end_time].present?

      if has_start_time && has_end_time
        attrs[:_destroy] = "0"
      elsif !has_start_time && !has_end_time
        attrs[:_destroy] = "1"
      else
        attrs[:_destroy] = "0"
      end
    end
  end
end
