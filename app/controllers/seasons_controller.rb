class SeasonsController < ApplicationController
  def show
    @season = Season.find(params[:id])
    @teams = @season.category.teams
    @matches = @season.matches
    @leaderboard = calculate_leaderboard(@teams)
  end

  private

  def calculate_leaderboard(teams)
    teams.map do |team|
      {
        team: team,
        played: team.matches_as_home.count + team.matches_as_away.count,
        won: team.scores.where(winner: team).count,
        lost: team.scores.where(loser: team).count,
        points: calculate_points(team)
      }
    end.sort_by { |entry| entry[:points] }.reverse
  end

  def calculate_points(team)
    total_points = 0
    team.matches_as_home.each do |match|
      if match.score.shotout?
        total_points += 2 if match.score.winner == team
        total_points += 1 if match.score.loser == team
      else
        total_points += 3 if match.score.winner == team
      end
    end
    total_points
  end
end
