class CreateTrainingAttendances < ActiveRecord::Migration[7.1]
  def change
    create_table :training_attendances do |t|
      t.references :athlete_card, null: false, foreign_key: true
      t.date :attended_on, null: false
      t.boolean :attended, null: false, default: true
      t.text :notes

      t.timestamps
    end

    add_index :training_attendances, [:athlete_card_id, :attended_on]
  end
end
