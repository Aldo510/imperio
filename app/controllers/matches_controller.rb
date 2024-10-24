class MatchesController < ApplicationController
  def edit
    @match = Match.find(params[:id])
  end

  def update
    @match = Match.find(params[:id])
    if @match.update(match_params)
      redirect_to matches_path, notice: 'Partido actualizado con éxito.'
    else
      render :edit
    end
  end

  private

  def match_params
    params.require(:match).permit(:home_team_score, :away_team_score, :shotout)
  end
end
