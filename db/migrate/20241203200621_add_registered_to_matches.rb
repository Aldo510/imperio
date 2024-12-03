class AddRegisteredToMatches < ActiveRecord::Migration[7.1]
  def change
    add_column :matches, :registered, :boolean
  end
end
