class DistancePricesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @distance_prices = DistancePrice.all
  end
  
  def new
    @distance_price = DistancePrice.new()
    @transport_modes = TransportMode.all
    if current_user.profile != "administrator"
      flash[:alert] = "Você não possui permissão."
      return redirect_to root_path
    end
  end
  def create
    @distance_price = DistancePrice.new(format_distance_price_params)
    if @distance_price.save()
      flash[:notice] = "Preço cadastrado com sucesso!"
      redirect_to distance_prices_path
    else
      @transport_modes = TransportMode.all
      flash.now[:notice] = "Preço não cadastrado."
      render 'new'
    end
  end
  
  def edit
    if current_user.administrator?
      @distance_price = DistancePrice.find(params[:id])
      @transport_modes = TransportMode.all
    else
      flash[:alert] = "Você não possui permissão."
      return redirect_to root_path
    end
  end
  def update
    @distance_price = DistancePrice.find(params[:id])
    if @distance_price.update(format_distance_price_params)
      flash[:notice] = "Preço atualizado com sucesso!"
      redirect_to distance_prices_path
    else
      @transport_modes = TransportMode.all
      flash.now[:notice] = "Não foi possível atualizar preço por distância."
      render 'new'
    end
  end

  private
  def distance_price_params
    distance_price_params = params.require(:distance_price).permit(:initial_distance, :ending_distance, 
                                                                    :price, :transport_mode_id)
  end  
  def format_distance_price_params
    format_params = distance_price_params
    format_params[:price] = distance_price_params[:price].gsub(',','.')
    format_params
  end
end