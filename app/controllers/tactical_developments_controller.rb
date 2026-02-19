class TacticalDevelopmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_school
  before_action :set_athlete_card
  before_action :set_tactical_development, only: %i[edit update destroy]

  def index
    @tactical_developments = @athlete_card.tactical_developments.includes(:team, :category).order(:evaluated_on, :created_at)
  end

  def new
    @tactical_development = @athlete_card.tactical_developments.new(evaluated_on: Date.current)
    preload_team_and_category
  end

  def edit
    preload_collections
  end

  def create
    @tactical_development = @athlete_card.tactical_developments.new(tactical_development_params)

    if @tactical_development.save
      redirect_to school_athlete_card_tactical_developments_path(@school, @athlete_card), notice: "Evaluación táctica registrada."
    else
      preload_collections
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @tactical_development.update(tactical_development_params)
      redirect_to school_athlete_card_tactical_developments_path(@school, @athlete_card), notice: "Evaluación táctica actualizada."
    else
      preload_collections
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @tactical_development.destroy
    redirect_to school_athlete_card_tactical_developments_path(@school, @athlete_card), notice: "Evaluación táctica eliminada."
  end

  private

  def set_school
    @school = School.find(params[:school_id])
  end

  def set_athlete_card
    @athlete_card = @school.athlete_cards.find(params[:athlete_card_id])
  end

  def set_tactical_development
    @tactical_development = @athlete_card.tactical_developments.find(params[:id])
  end

  def tactical_development_params
    params.require(:tactical_development).permit(
      :team_id,
      :category_id,
      :evaluated_on,
      :game_vision,
      :positioning_by_role,
      :mental_anticipation,
      :environment_adaptation,
      :counteracts_opponent_actions,
      :applies_offensive_tactical_fundamentals,
      :applies_defensive_tactical_fundamentals,
      :match_interval_management,
      :initiative_decision_making,
      :improvises_under_unexpected_situation,
      :communication_during_match,
      :notes
    )
  end

  def preload_team_and_category
    preload_collections

    latest = @athlete_card.tactical_developments.order(evaluated_on: :desc, created_at: :desc).first
    return if latest.blank?

    @tactical_development.team_id ||= latest.team_id
    @tactical_development.category_id ||= latest.category_id
  end

  def preload_collections
    @teams = Team.order(:name)
    @categories = Category.order(:name)
  end
end
