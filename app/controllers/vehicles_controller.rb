class VehiclesController < ApplicationController
  before_action :authenticate_user!

  def index
    @vehicles = Vehicle.all
  end

  def show
    @vehicle = Vehicle.find(params[:id])
  end
end