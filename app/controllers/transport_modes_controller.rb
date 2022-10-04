class TransportModesController < ApplicationController
  def new
   @transport_mode = TransportMode.new()
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
end