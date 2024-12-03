class AddScoresToMatches < ActiveRecord::Migration[7.1]
  def change
    add_column :matches, :home_score, :integer
    add_column :matches, :away_score, :integer
  end
end
