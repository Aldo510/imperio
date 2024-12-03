# app/services/players_pdf_generator.rb
require 'prawn'

class PlayersPdfGenerator
  def initialize(players)
    @players = players
  end

  def generate
    Prawn::Document.new do |pdf|
      @players.each_slice(4).with_index do |player_group, index|
        if index.positive?
          pdf.start_new_page
        end
        add_players(pdf, player_group)
      end
    end.render
  end

  private

  def add_players(pdf, players)
    players.each_with_index do |player, index|
      x = (index % 2) * 270 + 20
      y = 760 - (index / 2) * 380
      pdf.bounding_box([x, y], width: 250, height: 360) do
        pdf.stroke_bounds
        pdf.move_down 10
        pdf.text "Nombre: #{player.name}", size: 12, style: :bold
        pdf.move_down 10
        pdf.text "Apellido(s): #{player.last_name}", size: 12
        pdf.move_down 10
        pdf.text "Fecha de nacimiento: #{player.birthday&.strftime('%d/%m/%Y')}", size: 12
        pdf.move_down 10
        pdf.text "CURP: #{player.curp.upcase}", size: 12
        pdf.move_down 10
        pdf.text "Equipo: #{player.team.name}", size: 12
        
        pdf.move_down 20 # Añade espacio antes de la imagen

        if player.photo.attached?
          pdf.image StringIO.open(player.photo.download), fit: [120, 120], position: :center, vposition: :center
        else
          pdf.text "Foto no disponible", size: 12, style: :italic, align: :center
        end
      end
    end
  end
end
