class PlayersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_player, only: %i[ show edit update destroy show_pdf ]

  # GET /players or /players.json
  def index
    @players = Player.all
  end

  def download_pdf 
    @players = Player.all 
    pdf = PlayersPdfGenerator.new(@players).generate 
    
    send_data pdf, filename: "players.pdf", type: "application/pdf", disposition: "inline"
  end

  # GET /players/1 or /players/1.json
  def show
  end

  def show_pdf
    player = set_player # Encuentra al jugador basado en el ID

    # Conversión de mm a puntos (1 cm = 10 mm = 28.3465 puntos)
    page_width = 100 * 2.83465   # 10 cm de ancho
    page_height = 130 * 2.83465  # 15 cm de alto

    pdf = Prawn::Document.new(page_size: [page_width, page_height])

    # Definir las posiciones y tamaños de las columnas
    left_column_width = page_width / 3 # 1/3 del ancho total
    right_column_width = (page_width / 3) * 2 # 2/3 del ancho total

    # Primera Columna (Izquierda): Logo y Foto del Jugador
    pdf.bounding_box([0, pdf.cursor], width: left_column_width) do
      # Añadir logo
      logo_path = Rails.root.join('app', 'assets', 'images', 'logo.png')
      pdf.image logo_path, height: 60, width: 80, position: :left
      
      # Foto del jugador
      pdf.move_down 10
      if player.photo.attached?
        image_data = StringIO.open(player.photo.download)
        pdf.image image_data, fit: [80, 60], position: :center
      else
        player_path = Rails.root.join('app', 'assets', 'images', 'player-icon.png')
        pdf.image player_path, fit: [80, 60], position: :center
      end
    end

    logo_height = 120 # Ajusta esto según el tamaño real del logo es la suma de las dos alturas de logo y foto de player

    # Segunda Columna (Derecha): Título e Información del Jugador
    pdf.bounding_box([left_column_width, pdf.cursor + logo_height], width: right_column_width) do

      # Título
      pdf.text "Formato de registro 2024".upcase, size: 9, style: :bold, align: :left

      # Información del jugador
      pdf.move_down 20
      pdf.text "Folio: #{player.id}", size: 10
      pdf.move_down 10
      pdf.text "Nombre del Jugador:", size: 10
      pdf.text "#{player.full_name}", size: 10
      pdf.move_down 10
      pdf.text "Equipo del Jugador:", size: 10
      pdf.text "#{player.team.name}", size: 10
    end

    # Columna Inferior: Categoría, Fecha de Nacimiento, CURP, y Firma
    pdf.move_down 40
    pdf.text "Categoría: #{player.team.category.name}", size: 10
    pdf.move_down 10
    pdf.text "Fecha de Nacimiento: #{player.birthday.strftime('%d/%m/%Y')}", size: 10
    pdf.move_down 10
    pdf.text "CURP: #{player.curp.upcase}", size: 10

    # Espacio para la firma
    pdf.move_down 50
    pdf.stroke_horizontal_rule
    pdf.move_down 5
    pdf.text "Firma del Delegado", size: 10, align: :center

    # Enviar el PDF como respuesta
    respond_to do |format|
      format.pdf do
        send_data pdf.render, filename: "formato_registro_#{player.id}.pdf", type: "application/pdf", disposition: "inline"
      end
    end
  end

  # GET /players/new
  def new
    @player = Player.new
  end

  # GET /players/1/edit
  def edit
  end

  # POST /players or /players.json
  def create
    @player = Player.new(player_params)

    respond_to do |format|
      if @player.save
        format.html { redirect_to player_url(@player), notice: "Player was successfully created." }
        format.json { render :show, status: :created, location: @player }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /players/1 or /players/1.json
  def update
    respond_to do |format|
      if @player.update(player_params)
        format.html { redirect_to player_url(@player), notice: "Player was successfully updated." }
        format.json { render :show, status: :ok, location: @player }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /players/1 or /players/1.json
  def destroy
    @player.destroy!

    respond_to do |format|
      format.html { redirect_to players_url, notice: "Player was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Player.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def player_params
      params.require(:player).permit(:name, :last_name, :birthday, :curp, :team_id, :photo)
    end
  end
