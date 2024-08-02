class CreatePlayers < ActiveRecord::Migration[7.1]
  def change
    create_table :players do |t|
      t.string :name
      t.string :last_name
      t.date :birthday
      t.string :curp
      t.references :team, null: false, foreign_key: true

      t.timestamps
    end
  end
end
