class Category < ApplicationRecord
	has_many :teams, dependent: :destroy
end
