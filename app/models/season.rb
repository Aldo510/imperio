class Season < ApplicationRecord
  belongs_to :category
  has_many :matches

  def schedule_matches(repeats: 1)
    teams = category.teams
    team_pairs = teams.to_a.combination(2) # Genera todas las combinaciones de 2 equipos
  
    team_pairs.each do |team_pair|
      home_team, away_team = team_pair
      repeats.times do
        matches.create(home_team: home_team, away_team: away_team, date: random_match_time)
        # Si no quieres que se enfrenten dos veces, elimina la línea siguiente:
        # matches.create(home_team: away_team, away_team: home_team, date: random_match_time)
      end
    end
  end  

  private

  def random_match_time
    saturday_or_sunday = [6, 0].sample # 6 for Saturday, 0 for Sunday
    Time.zone.now.beginning_of_week + saturday_or_sunday.days + rand(8..17).hours
  end

end
