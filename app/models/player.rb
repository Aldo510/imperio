class Player < ApplicationRecord
  belongs_to :team
  has_one_attached :photo

  class YourModel < ApplicationRecord
  validates :curp, format: { with: /\A([A-Z]{1}[AEIOU]{1}[A-Z]{2})(\d{2})(\d{2})(\d{2})([HM]{1})([A-Z]{2})([B-DF-HJ-NP-TV-Z]{3})([A-Z\d]{1})(\d{1})\z/,
                             message: "formato de CURP inválido" },
                   uniqueness: true
  end


end
