class VehiclesController < ApplicationController
  before_action :authenticate_user!

  def index
    @vehicles = Vehicle.all
  end

  def show
    @vehicle = Vehicle.find(params[:id])
  end

  def new
    if current_user.administrator?
      @vehicle = Vehicle.new
      @transport_modes = TransportMode.all
    else
      flash[:alert] = "Você não possui permissão."
      return redirect_to root_path
    end
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

  def edit
    if current_user.administrator?
      @vehicle = Vehicle.find(params[:id])
      @transport_modes = TransportMode.all
    else
      flash[:alert] = "Você não possui permissão."
      return redirect_to root_path
    end
  end
  def update
    @vehicle = Vehicle.find(params[:id])
    if @vehicle.update(vehicle_params)
      flash[:notice] = "Veículo atualizado com sucesso!"
      redirect_to @vehicle
    else
      @transport_modes = TransportMode.all
      flash.now[:notice] = "Não foi possível atualizar veículo."
      render 'new'
    end
  end

  def search
    @search = params['query']
    @vehicles = Vehicle.where("plate LIKE ?", "%#{@search}%")
  end

  private
  def vehicle_params
    vehicle_params = params.require(:vehicle).permit(:plate, :brand, :model, :year, 
                                                    :weight_limit, :transport_mode_id, :status)
  end
end