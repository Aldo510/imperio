class Category < ApplicationRecord
  has_many :teams, dependent: :destroy
  has_many :seasons, dependent: :destroy
  has_many :technical_developments, dependent: :destroy
  has_many :tactical_developments, dependent: :destroy
end
