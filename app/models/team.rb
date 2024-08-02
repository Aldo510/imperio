class Team < ApplicationRecord
  belongs_to :category
  has_one_attached :logo
  has_many :players, dependent: :destroy
end
