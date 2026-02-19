class CreateAthleteCards < ActiveRecord::Migration[7.1]
  def change
    create_table :athlete_cards do |t|
      t.references :school, null: false, foreign_key: true
      t.string :name, null: false
      t.date :birth_date, null: false
      t.string :curp, null: false
      t.integer :age, null: false
      t.string :guardian_name, null: false
      t.string :phone_number, null: false
      t.string :size, null: false
      t.decimal :weight_kg, precision: 5, scale: 2
      t.decimal :height_cm, precision: 5, scale: 2
      t.integer :dominant_profile, null: false, default: 0
      t.integer :skill_level, null: false, default: 0

      t.timestamps
    end

    add_index :athlete_cards, :curp, unique: true
  end
end
