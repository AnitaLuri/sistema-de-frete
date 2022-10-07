class WeightPricesController < ApplicationController
  def new 
    @weight_price = WeightPrice.new()
    @transport_modes = TransportMode.all
    if current_user.profile != "administrator"
      flash[:alert] = "Você não possui permissão."
      return redirect_to root_path
    end
  end
  
  def create
    @weight_price = WeightPrice.new(weight_price_params)
    if @weight_price.save()
      flash[:notice] = "Veículo cadastrado com sucesso!"
      redirect_to weight_prices_path
    else
      @transport_modes = TransportMode.all
      flash.now[:notice] = "Veículo não cadastrado."
      render 'new'
    end
  end

  def index
    @weight_prices = WeightPrice.all
  end

  private
  def weight_price_params
    weight_price_params = params.require(:weight_price).permit(:initial_weight, :ending_weight, :km_value,
                                                               :transport_mode_id)
  end
end