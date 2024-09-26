class Player < ApplicationRecord
  belongs_to :team
  has_one_attached :photo

  validates :curp, format: { with: /\A([A-Za-z]{1}[Aeiouaeiou]{1}[A-Za-z]{2})(\d{2})(\d{2})(\d{2})([HMhm]{1})([A-Za-z]{2})([B-DF-HJ-NP-TV-Zb-df-hj-np-tv-z]{3})([A-Za-z\d]{1})(\d{1})\z/i,
                             message: "formato de CURP inválido" },
                   uniqueness: true

  before_save :upcase_curp

  def full_name
    "#{name} #{last_name}"
  end
  
  private 

  def upcase_curp
    self.curp = curp.upcase if curp.present?
  end
end
