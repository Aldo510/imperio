class TrainingAttendancesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_school
  before_action :set_athlete_card
  before_action :set_training_attendance, only: %i[edit update destroy]

  def index
    @training_attendances = @athlete_card.training_attendances.order(attended_on: :desc)
  end

  def new
    @training_attendance = @athlete_card.training_attendances.new(attended: true)
  end

  def create
    @training_attendance = @athlete_card.training_attendances.new(training_attendance_params)

    if @training_attendance.save
      redirect_to school_athlete_card_training_attendances_path(@school, @athlete_card), notice: "Asistencia de entrenamiento registrada."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @training_attendance.update(training_attendance_params)
      redirect_to school_athlete_card_training_attendances_path(@school, @athlete_card), notice: "Asistencia de entrenamiento actualizada."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @training_attendance.destroy
    redirect_to school_athlete_card_training_attendances_path(@school, @athlete_card), notice: "Asistencia de entrenamiento eliminada."
  end

  private

  def set_school
    @school = School.find(params[:school_id])
  end

  def set_athlete_card
    @athlete_card = @school.athlete_cards.find(params[:athlete_card_id])
  end

  def set_training_attendance
    @training_attendance = @athlete_card.training_attendances.find(params[:id])
  end

  def training_attendance_params
    params.require(:training_attendance).permit(:attended_on, :attended, :notes)
  end
end
