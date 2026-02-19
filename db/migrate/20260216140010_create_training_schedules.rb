class CreateTrainingSchedules < ActiveRecord::Migration[7.1]
  def change
    create_table :training_schedules do |t|
      t.references :athlete_card, null: false, foreign_key: true
      t.integer :day_of_week, null: false
      t.time :start_time, null: false
      t.time :end_time, null: false

      t.timestamps
    end

    add_index :training_schedules, [:athlete_card_id, :day_of_week], unique: true
  end
end
