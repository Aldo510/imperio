class SchoolsController < ApplicationController
    before_action :authenticate_user!, only: %i[new update destroy index]
    before_action :set_school, only: %i[show edit update destroy]
  
    def index
      @schools = School.all
    end
  
    def show
    end
  
    def new
      @school = School.new
    end
  
    def create
      @school = School.new(school_params)
      if @school.save
        redirect_to @school, notice: 'Escuela creada con éxito.'
      else
        render :new
      end
    end
  
    def edit
    end
  
    def update
      if @school.update(school_params)
        redirect_to @school, notice: 'Escuela actualizada con éxito.'
      else
        render :edit
      end
    end
  
    def destroy
      @school.destroy
      redirect_to schools_path, notice: 'Escuela eliminada con éxito.'
    end
  
    private
  
    def set_school
      @school = School.find(params[:id])
    end
  
    def school_params
      params.require(:school).permit(:name, :description, :info, :schedules, :location, :monthly_fee, images: [])
    end
  end
  