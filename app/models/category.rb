class Category < ApplicationRecord
	has_many :teams, dependent: :destroy
	has_many :seasons, dependent: :destroy
end
