class WeightPricesController < ApplicationController
  before_action :authenticate_user!

  def index
    @weight_prices = WeightPrice.all.order(:initial_weight, ending_weight: :asc)
  end

  def new 
    @weight_price = WeightPrice.new()
    @transport_modes = TransportMode.all.order(name: :asc)
    if current_user.profile != "administrator"
      flash[:alert] = "Você não possui permissão."
      return redirect_to root_path
    end
  end
  def create
    @weight_price = WeightPrice.new(format_weight_price_params)
    if @weight_price.save()
      flash[:notice] = "Preço cadastrado com sucesso!"
      redirect_to weight_prices_path
    else
      @transport_modes = TransportMode.all.order(name: :asc)
      flash.now[:notice] = "Preço não cadastrado."
      render 'new'
    end
  end

  def edit
    if current_user.administrator?
      @weight_price = WeightPrice.find(params[:id])
      @transport_modes = TransportMode.all.order(name: :asc)
    else
      flash[:alert] = "Você não possui permissão."
      return redirect_to root_path
    end
  end
  def update
    @weight_price = WeightPrice.find(params[:id])
    if @weight_price.update(format_weight_price_params)
      flash[:notice] = "Preço atualizado com sucesso!"
      redirect_to weight_prices_path
    else
      @transport_modes = TransportMode.all.order(name: :asc)
      flash.now[:notice] = "Não foi possível atualizar preço por peso."
      render 'new'
    end
  end

  private
  def weight_price_params
    weight_price_params = params.require(:weight_price).permit(:initial_weight, :ending_weight, :km_value,
                                                               :transport_mode_id)
  end
  def format_weight_price_params
    format_params = weight_price_params
    format_params[:km_value] = weight_price_params[:km_value].gsub(',','.')
    format_params
  end
end