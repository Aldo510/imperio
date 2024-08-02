json.extract! team, :id, :name, :logo, :category_id, :created_at, :updated_at
json.url team_url(team, format: :json)
json.logo url_for(team.logo)
