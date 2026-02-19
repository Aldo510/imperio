class TechnicalDevelopmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_school
  before_action :set_athlete_card
  before_action :set_technical_development, only: %i[edit update destroy]

  def index
    @technical_developments = @athlete_card.technical_developments.includes(:team, :category).order(:evaluated_on, :created_at)
  end

  def new
    @technical_development = @athlete_card.technical_developments.new(evaluated_on: Date.current)
    preload_team_and_category
  end

  def edit
    preload_collections
  end

  def create
    @technical_development = @athlete_card.technical_developments.new(technical_development_params)

    if @technical_development.save
      redirect_to school_athlete_card_technical_developments_path(@school, @athlete_card), notice: "Evaluación técnica registrada."
    else
      preload_collections
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @technical_development.update(technical_development_params)
      redirect_to school_athlete_card_technical_developments_path(@school, @athlete_card), notice: "Evaluación técnica actualizada."
    else
      preload_collections
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @technical_development.destroy
    redirect_to school_athlete_card_technical_developments_path(@school, @athlete_card), notice: "Evaluación técnica eliminada."
  end

  private

  def set_school
    @school = School.find(params[:school_id])
  end

  def set_athlete_card
    @athlete_card = @school.athlete_cards.find(params[:athlete_card_id])
  end

  def set_technical_development
    @technical_development = @athlete_card.technical_developments.find(params[:id])
  end

  def technical_development_params
    params.require(:technical_development).permit(
      :team_id,
      :category_id,
      :evaluated_on,
      :conduction,
      :reception,
      :passing,
      :finishing,
      :dribbling,
      :throw_in,
      :heading,
      :dispossession,
      :shielding,
      :sliding_tackle,
      :notes
    )
  end

  def preload_team_and_category
    preload_collections

    latest = @athlete_card.technical_developments.order(evaluated_on: :desc, created_at: :desc).first
    return if latest.blank?

    @technical_development.team_id ||= latest.team_id
    @technical_development.category_id ||= latest.category_id
  end

  def preload_collections
    @teams = Team.order(:name)
    @categories = Category.order(:name)
  end
end
