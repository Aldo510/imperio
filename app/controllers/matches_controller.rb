class MatchesController < ApplicationController
  def edit
    @match = Match.find(params[:id])
  end

  def update
    @match = Match.find(params[:id])
    
    # Combinar fecha y hora desde el formulario
    match_date = params[:match][:date]
    match_time = params[:match][:time]
    
    if @match.update(date: "#{match_date} #{match_time}", home_score: params[:match][:home_score], away_score: params[:match][:away_score])
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
