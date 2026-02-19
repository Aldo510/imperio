class CreateWeekendMatchAttendances < ActiveRecord::Migration[7.1]
  def change
    create_table :weekend_match_attendances do |t|
      t.references :athlete_card, null: false, foreign_key: true
      t.date :match_date, null: false
      t.integer :weekend_day, null: false
      t.boolean :attended, null: false, default: true
      t.string :opponent
      t.text :notes

      t.timestamps
    end

    add_index :weekend_match_attendances, [:athlete_card_id, :match_date]
  end
end
