class CreateScores < ActiveRecord::Migration[7.1]
  def change
    create_table :scores do |t|
      t.references :match, null: false, foreign_key: true
      t.integer :home_team_score
      t.integer :away_team_score
      t.boolean :shotout

      t.timestamps
    end
  end
end
