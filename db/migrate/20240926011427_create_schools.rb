class CreateSchools < ActiveRecord::Migration[7.1]
  def change
    create_table :schools do |t|
      t.string :name
      t.text :description
      t.text :info
      t.text :schedules
      t.string :location
      t.decimal :monthly_fee

      t.timestamps
    end
  end
end
