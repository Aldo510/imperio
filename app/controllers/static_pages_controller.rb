class StaticPagesController < ApplicationController
  def index
    @schools = School.all
  end
end
