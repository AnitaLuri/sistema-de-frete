class VehiclesController < ApplicationController
  before_action :authenticate_user!

  def index
    @vehicles = Vehicle.all
  end

  def show
    @vehicle = Vehicle.find(params[:id])
  end

  def new
    if current_user.profile != "administrator"
      flash[:alert] = "Você não possui permissão."
      return redirect_to root_path
    end
    @vehicle = Vehicle.new
    @transport_modes = TransportMode.all
  end
  def create
    @vehicle = Vehicle.new(vehicle_params)
    if @vehicle.save()
      flash[:notice] = "Veículo cadastrado com sucesso!"
      redirect_to @vehicle
    else
      @transport_modes = TransportMode.all
      flash.now[:notice] = "Veículo não cadastrado."
      render 'new'
    end
  end


  private
  def vehicle_params
    vehicle_params = params.require(:vehicle).permit(:plate, :brand, :model, :year, 
                                                    :weight_limit, :transport_mode_id, :status)
  end
end