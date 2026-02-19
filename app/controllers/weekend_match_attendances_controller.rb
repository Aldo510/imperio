class WeekendMatchAttendancesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_school
  before_action :set_athlete_card
  before_action :set_weekend_match_attendance, only: %i[edit update destroy]

  def index
    @weekend_match_attendances = @athlete_card.weekend_match_attendances.order(match_date: :desc)
  end

  def new
    @weekend_match_attendance = @athlete_card.weekend_match_attendances.new(attended: true)
  end

  def create
    @weekend_match_attendance = @athlete_card.weekend_match_attendances.new(weekend_match_attendance_params)

    if @weekend_match_attendance.save
      redirect_to school_athlete_card_weekend_match_attendances_path(@school, @athlete_card), notice: "Asistencia de partido registrada."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @weekend_match_attendance.update(weekend_match_attendance_params)
      redirect_to school_athlete_card_weekend_match_attendances_path(@school, @athlete_card), notice: "Asistencia de partido actualizada."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @weekend_match_attendance.destroy
    redirect_to school_athlete_card_weekend_match_attendances_path(@school, @athlete_card), notice: "Asistencia de partido eliminada."
  end

  private

  def set_school
    @school = School.find(params[:school_id])
  end

  def set_athlete_card
    @athlete_card = @school.athlete_cards.find(params[:athlete_card_id])
  end

  def set_weekend_match_attendance
    @weekend_match_attendance = @athlete_card.weekend_match_attendances.find(params[:id])
  end

  def weekend_match_attendance_params
    params.require(:weekend_match_attendance).permit(:match_date, :weekend_day, :attended, :opponent, :notes)
  end
end
