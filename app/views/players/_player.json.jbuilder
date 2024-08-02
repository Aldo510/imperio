json.extract! player, :id, :name, :last_name, :birthday, :curp, :team_id, :created_at, :updated_at
json.url player_url(player, format: :json)
