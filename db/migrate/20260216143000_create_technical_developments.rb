class CreateTechnicalDevelopments < ActiveRecord::Migration[7.1]
  def change
    create_table :technical_developments do |t|
      t.references :athlete_card, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.date :evaluated_on, null: false
      t.integer :conduction, null: false, default: 1
      t.integer :reception, null: false, default: 1
      t.integer :passing, null: false, default: 1
      t.integer :finishing, null: false, default: 1
      t.integer :dribbling, null: false, default: 1
      t.integer :throw_in, null: false, default: 1
      t.integer :heading, null: false, default: 1
      t.integer :dispossession, null: false, default: 1
      t.integer :shielding, null: false, default: 1
      t.integer :sliding_tackle, null: false, default: 1
      t.text :notes

      t.timestamps
    end

    add_index :technical_developments, [:athlete_card_id, :evaluated_on]
  end
end
