class Player < ApplicationRecord
  belongs_to :team
  has_one_attached :photo
end
