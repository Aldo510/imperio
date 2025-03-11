class StaticPagesController < ApplicationController
  def index
    @schools = School.all
  end
  
  def generate_pdf
    respond_to do |format|
      format.pdf do
        pdf = Prawn::Document.new(page_size: 'LETTER')
        pdf.text "CATEGORIA", size: 18, style: :bold, align: :center
        pdf.move_down 20

        pdf.text "FICHA DE ENTRENAMIENTO", size: 14, style: :bold, align: :center
        pdf.move_down 20

        pdf.text "Esquemas Tácticos & Mecanizaciones", size: 12, style: :bold
        pdf.move_down 10

        data = [
          ["No.", "Hombre", "Asís.", "Causa o lesión", "No.", "Hombre", "Asís.", "Causa o lesión"],
          ["", "", "", "", "", "", "", ""],
          ["", "", "", "", "", "", "", ""],
          ["", "", "", "", "", "", "", ""]
        ]

        pdf.table(data, width: pdf.bounds.width) do
          row(0).font_style = :bold
        end

        pdf.move_down 20

        pdf.text "FICHA DE ENTRENAMIENTO", size: 14, style: :bold, align: :center
        pdf.move_down 20

        pdf.text "Hrs. Inicio | Hrs. Final | Lugar | Fecha | # Jug.", size: 12
        pdf.move_down 10

        pdf.text "Período | Microciclo | T/N de Sesión | Turno | Categoría", size: 12
        pdf.move_down 20

        pdf.text "Parte introductoria", size: 12, style: :bold
        pdf.move_down 10

        pdf.text "OBJETIVOS:", size: 12, style: :bold
        pdf.move_down 10

        pdf.text "Tipo    Resumen    Tiempo", size: 12
        pdf.text "Calentamiento", size: 12
        pdf.text "Fisico", size: 12
        pdf.text "Descripción del Entrenamiento", size: 12
        pdf.move_down 20

        pdf.text "Parte Central", size: 12, style: :bold
        pdf.move_down 10

        pdf.text "Tipo    Resumen    Tiempo", size: 12
        pdf.text "Técnico", size: 12
        pdf.text "Táctico", size: 12
        pdf.text "Otros", size: 12
        pdf.text "Descripción del Entrenamiento", size: 12

        send_data pdf.render, filename: "entrenamiento.pdf", type: "application/pdf", disposition: "inline"
      end
    end
  end

end
