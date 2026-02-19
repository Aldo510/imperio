class CreateTacticalDevelopments < ActiveRecord::Migration[7.1]
  def change
    create_table :tactical_developments do |t|
      t.references :athlete_card, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.date :evaluated_on, null: false
      t.integer :game_vision, null: false, default: 1
      t.integer :positioning_by_role, null: false, default: 1
      t.integer :mental_anticipation, null: false, default: 1
      t.integer :environment_adaptation, null: false, default: 1
      t.integer :counteracts_opponent_actions, null: false, default: 1
      t.integer :applies_offensive_tactical_fundamentals, null: false, default: 1
      t.integer :applies_defensive_tactical_fundamentals, null: false, default: 1
      t.integer :match_interval_management, null: false, default: 1
      t.integer :initiative_decision_making, null: false, default: 1
      t.integer :improvises_under_unexpected_situation, null: false, default: 1
      t.integer :communication_during_match, null: false, default: 1
      t.text :notes

      t.timestamps
    end

    add_index :tactical_developments, [:athlete_card_id, :evaluated_on]
  end
end
