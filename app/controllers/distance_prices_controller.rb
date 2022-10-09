class DistancePricesController < ApplicationController
  before_action :authenticate_user!
   
  def new
    @distance_price = DistancePrice.new()
    @transport_modes = TransportMode.all
    if current_user.profile != "administrator"
      flash[:alert] = "Você não possui permissão."
      return redirect_to root_path
    end
  end
  def create
    @distance_price = DistancePrice.new(distance_price_params)
    if @distance_price.save()
      flash[:notice] = "Preço cadastrado com sucesso!"
      redirect_to distance_prices_path
    else
      @transport_modes = TransportMode.all
      flash.now[:notice] = "Preço não cadastrado."
      render 'new'
    end
  end
  def index
    @distance_prices = DistancePrice.all
  end


  private
  def distance_price_params
    distance_price_params = params.require(:distance_price).permit(:initial_distance, :ending_distance, 
                                                                    :price, :transport_mode_id)
  end  
end