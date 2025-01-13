class AddCascadeToForeignKeys < ActiveRecord::Migration[7.1]
  def change
    # Elimina las claves foráneas existentes
    remove_foreign_key :matches, :teams, column: :away_team_id
    remove_foreign_key :matches, :teams, column: :home_team_id
    remove_foreign_key :players, :teams

    # Añade claves foráneas con eliminación en cascada
    add_foreign_key :matches, :teams, column: :away_team_id, on_delete: :cascade
    add_foreign_key :matches, :teams, column: :home_team_id, on_delete: :cascade
    add_foreign_key :players, :teams, on_delete: :cascade
  end
end
