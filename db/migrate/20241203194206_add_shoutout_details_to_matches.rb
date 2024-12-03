class AddShoutoutDetailsToMatches < ActiveRecord::Migration[7.1]
  def change
    add_column :matches, :shoutout_winner, :integer
    add_column :matches, :shotout, :string
    add_column :matches, :boolean, :string
  end
end
