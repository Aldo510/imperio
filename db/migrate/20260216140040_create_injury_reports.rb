class CreateInjuryReports < ActiveRecord::Migration[7.1]
  def change
    create_table :injury_reports do |t|
      t.references :athlete_card, null: false, foreign_key: true
      t.string :injury_name, null: false
      t.text :observations
      t.date :reported_on
      t.boolean :active, null: false, default: true

      t.timestamps
    end
  end
end
