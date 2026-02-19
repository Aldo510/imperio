class CreateResultPaths < ActiveRecord::Migration[7.1]
  def change
    create_table :result_paths do |t|
      t.references :athlete_card, null: false, foreign_key: true
      t.integer :term, null: false
      t.text :goal, null: false
      t.text :notes

      t.timestamps
    end

    add_index :result_paths, [:athlete_card_id, :term], unique: true
  end
end
