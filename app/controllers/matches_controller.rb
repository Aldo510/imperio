class MatchesController < ApplicationController
  before_action :set_match, only: %i[show edit update destroy]

  def index
    @matches = Match.all
  end

  def show
  end

  def new
    @match = Match.new
    @match.build_score
  end

  def edit
    @match.build_score unless @match.score
  end

  def create
    @match = Match.new(match_params)

    respond_to do |format|
      if @match.save
        format.html { redirect_to @match, notice: 'Match was successfully created.' }
        format.json { render :show, status: :created, location: @match }
      else
        format.html { render :new }
        format.json { render json: @match.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @match.update(match_params)
        #format.html { redirect_to @match.season, notice: 'Match was successfully updated.' }
        format.html { redirect_to @match, notice: 'Match was successfully updated.' }
        format.json { render :show, status: :ok, location: @match }
      else
        format.html { render :edit }
        format.json { render json: @match.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @match.destroy
    respond_to do |format|
      format.html { redirect_to matches_url, notice: 'Match was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_match
    @match = Match.find(params[:id])
  end

  def match_params
    params.require(:match).permit(:date, :home_team_id, :away_team_id, :season_id, :shotout, :shoutout_winner, :registered, score_attributes: [:home_score, :away_score])
  end
end
