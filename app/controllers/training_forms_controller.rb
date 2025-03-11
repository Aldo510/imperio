class TrainingFormsController < ApplicationController
  require 'prawn/table' # Requerir la gema prawn-table

  def new
    # No necesitamos un modelo, solo renderizamos la vista del formulario
  end

  def generate_pdf
    # Recuperamos los datos del formulario
    dt = params[:dt]
    pf = params[:pf]
    torneo = params[:torneo]
    fecha_entrenamiento = params[:fecha_entrenamiento]
    hrs_inicio = params[:hrs_inicio]
    hrs_final = params[:hrs_final]
    lugar = params[:lugar]
    fecha = params[:fecha]
    num_jugadores = params[:num_jugadores]
    periodo = params[:periodo]
    microciclo = params[:microciclo]
    sesion = params[:sesion]
    turno = params[:turno]
    categoria = params[:categoria]

    respond_to do |format|
      format.pdf do
        pdf = Prawn::Document.new(page_size: 'LETTER')

        # Primera tabla: Torneo y Fecha de Entrenamiento
        pdf.table([
          ["Torneo", "Fecha de Entrenamiento"],
          [torneo, fecha_entrenamiento]
        ], width: pdf.bounds.width, cell_style: { borders: [:bottom], border_width: 1, align: :center }) do |table|
          table.row(0).font_style = :bold
          table.row(0).background_color = "E0E0E0"
        end

        # Segunda sección: Columna izquierda (1/3) y columna derecha (2/3)
        pdf.bounding_box([0, pdf.cursor], width: pdf.bounds.width) do
          pdf.table([
            [
              { content: "<i>D.T.</i>\n<i>P.F.</i>", inline_format: true },
              {
                content: pdf.make_table([
                  ["Hrs. Inicio", "Hrs. Final", "Lugar", "Fecha", "# Jug."],
                  [hrs_inicio, hrs_final, lugar, fecha, num_jugadores],
                  ["Período", "Microciclo", "T/N de Sesión", "Turno", "Categoría"],
                  [periodo, microciclo, sesion, turno, categoria],
                ], width: pdf.bounds.width * 2 / 3) # Asegurar que la tabla ocupe el 100% del espacio disponible (2/3)
              }
            ]
          ], width: pdf.bounds.width, column_widths: [pdf.bounds.width / 3, pdf.bounds.width * 2 / 3], cell_style: { borders: [:bottom], border_width: 1 }) do |table|
            table.row(0).column(0).padding = [20, 20] # Ajustar padding para la columna izquierda
            table.row(0).column(1).padding = [0, 0]   # Ajustar padding para la columna derecha
          end
        end

        # Tercera sección: Parte introductoria
        pdf.move_down 5 # Espacio antes del título
        pdf.bounding_box([0, pdf.cursor], width: pdf.bounds.width) do
          pdf.text "Parte introductoria", size: 14, style: :bold, align: :center
          pdf.stroke_horizontal_rule # Línea horizontal como borde inferior
        end

        # Cuarta sección: Objetivos y Media Cancha
        pdf.move_down 5 # Espacio antes de la nueva sección
        pdf.bounding_box([0, pdf.cursor], width: pdf.bounds.width) do
          # Columna izquierda (50%): Objetivos
          pdf.float do
            pdf.bounding_box([0, pdf.cursor], width: pdf.bounds.width / 2) do
              pdf.text "Objetivos:", size: 14, style: :bold
              pdf.move_down 30 # Espacio antes de la nueva sección
              pdf.table([
                ["Tipo", "Resumen", "Tiempo"],
                ["", "", ""], # Fila vacía para datos
                ["Calentamiento", "", ""],
                ["Físico", "", ""],
                [{ content: "Descripción del Entrenamiento", align: :center, colspan: 3 }]
              ], width: pdf.bounds.width, cell_style: { borders: [:bottom], border_width: 1, padding: [5, 10] }) do |table|
                table.row(0).font_style = :bold
                table.row(0).background_color = "E0E0E0"
              end
            end
          end

          # Columna derecha (50%): Imagen media_cancha.png
          pdf.bounding_box([pdf.bounds.width / 2, pdf.cursor], width: pdf.bounds.width) do
            pdf.image Rails.root.join('app', 'assets', 'images', 'media_cancha.jpg'), width: pdf.bounds.width / 2
          end
        end

         # Quinta secc: Parte introductoria
         pdf.move_down 5 # Espacio antes del título
         pdf.bounding_box([0, pdf.cursor], width: pdf.bounds.width) do
            pdf.stroke_horizontal_rule # Línea horizontal como borde inferior
            pdf.move_down 5 # Espacio antes del título
            pdf.text "Parte central", size: 14, style: :bold, align: :center
            pdf.stroke_horizontal_rule # Línea horizontal como borde inferior
         end

        # Quinta sección: Parte Central
        pdf.move_down 5 # Espacio antes de la nueva sección
        pdf.bounding_box([0, pdf.cursor], width: pdf.bounds.width) do
          # Columna izquierda (50%): Tabla y texto
          pdf.float do
            pdf.bounding_box([0, pdf.cursor], width: pdf.bounds.width) do
              # Tabla con "Tipo", "Resumen", "Tiempo"
              pdf.table([
                ["Tipo", "Resumen", "Tiempo"],
                ["", "", ""] # Fila vacía para datos
              ], width: pdf.bounds.width / 2, cell_style: { borders: [:bottom], border_width: 1, padding: [5, 10] }) do |table|
                table.row(0).font_style = :bold
                table.row(0).background_color = "E0E0E0"
              end

              # Espacio después de la tabla
              pdf.move_down 40
              pdf.text "Técnico:", size: 12
              pdf.move_down 5
              pdf.text "Táctico:", size: 12
              pdf.move_down 5
              pdf.text "Otros:", size: 12

              pdf.move_down 15
              pdf.text "Descripción del entrenamiento:", size: 14, style: :bold
            end
          end

          # Columna derecha (50%): Imagen cancha.jpg
          pdf.bounding_box([pdf.bounds.width / 2, pdf.cursor], width: pdf.bounds.width * 4 / 5) do
            pdf.image Rails.root.join('app', 'assets', 'images', 'cancha.jpg'), width: pdf.bounds.width / 2
          end
        end

        pdf.start_new_page

        pdf.bounding_box([0, pdf.cursor], width: pdf.bounds.width) do
          pdf.text "Esquema táctico y mecanizaciones", size: 14, style: :bold, align: :center
          pdf.stroke_horizontal_rule # Línea horizontal como borde inferior
        end

        pdf.bounding_box([0, pdf.cursor], width: pdf.bounds.width) do
          # Columna izquierda (50%): Tabla y texto
          pdf.float do
            pdf.bounding_box([0, pdf.cursor], width: pdf.bounds.width) do
              pdf.move_down 15
              pdf.text "Descripción del entrenamiento:", size: 14, style: :bold
            end
          end

          # Columna derecha (50%): Imagen cancha.jpg
          pdf.bounding_box([pdf.bounds.width / 2, pdf.cursor], width: pdf.bounds.width) do
            pdf.image Rails.root.join('app', 'assets', 'images', 'cancha.jpg'), width: pdf.bounds.width / 2
          end
        end

        pdf.bounding_box([0, pdf.cursor], width: pdf.bounds.width) do
          pdf.stroke_horizontal_rule # Línea horizontal como borde inferior
          pdf.move_down 5
          pdf.text "Entrenamiento", size: 14, style: :bold, align: :center
          pdf.stroke_horizontal_rule # Línea horizontal como borde inferior
        end

        # Crear la tabla con 10 filas
        pdf.table([
          # Encabezados de la tabla
          ["No", "Nombre", "Asis", "Causa o lesión", "No", "Nombre", "Asis", "Causa o lesión"],
          # Filas vacías (del 2 al 9)
          ["", "", "", "", "", "", "", ""],
          ["", "", "", "", "", "", "", ""],
          ["", "", "", "", "", "", "", ""],
          ["", "", "", "", "", "", "", ""],
          ["", "", "", "", "", "", "", ""],
          ["", "", "", "", "", "", "", ""],
          ["", "", "", "", "", "", "", ""],
          ["", "", "", "", "", "", "", ""],
          ["", "", "", "", "", "", "", ""],
          ["", "", "", "", "", "", "", ""],
          ["", "", "", "", "", "", "", ""],
          ["", "", "", "", "", "", "", ""]
        ], width: pdf.bounds.width, cell_style: { borders: [:top, :bottom, :left, :right], border_width: 1, padding: [5, 10] }) do |table|
          # Ajustar el estilo de la primera fila (encabezados)
          table.row(0).font_style = :bold
          table.row(0).background_color = "E0E0E0"
          table.row(0).align = :center

          # Ajustar la altura de las filas del 2 al 9
          (1..12).each do |i|
            table.row(i).height = 20 # Aumentar la altura de las filas vacías
            table.row(i).padding = [10, 10] # Aumentar el padding en las filas vacías
          end
        end

        send_data pdf.render, filename: "entrenamiento.pdf", type: "application/pdf", disposition: "inline"
      end
    end

    
  end
end