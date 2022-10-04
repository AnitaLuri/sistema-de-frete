class TransportModesController < ApplicationController
  before_action :authenticate_user!
  def new
    @transport_mode = TransportMode.new()
    if current_user.profile != "administrator"
      flash[:alert] = "Você não possui permissão."
      return redirect_to root_path
    end
  end

  def create
    transport_mode_params = params.require(:transport_mode).permit(:name, :minimum_distance, :maximum_distance, 
                                                                  :minimum_weight, :maximum_weight, :fixed_value)
    @transport_mode = TransportMode.new(transport_mode_params)
    if @transport_mode.save
      flash[:notice] = 'Modalidade de Transporte criada com sucesso!' 
      redirect_to root_path
    else
      flash.now[:notice] = 'Modalidade de Transporte não cadastrada.'
      render 'new'
    end
  end

  def show
    @transport_mode = TransportMode.find(params[:id])
  end
end