class AddStatsToTeams < ActiveRecord::Migration[7.1]
  def change
    add_column :teams, :points, :integer
    add_column :teams, :wins, :integer
    add_column :teams, :draws, :integer
    add_column :teams, :losses, :integer
    add_column :teams, :shotout_wins, :integer
    add_column :teams, :shotout_losses, :integer
  end
end
