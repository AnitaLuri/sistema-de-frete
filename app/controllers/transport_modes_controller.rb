class TransportModesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_transport_mode, only: [:show, :edit, :update, :active, :inactive ]
 
  def new
    @transport_mode = TransportMode.new()
    if current_user.profile != "administrator"
      flash[:alert] = "Você não possui permissão."
      return redirect_to root_path
    end
  end

  def create
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
  end

  def edit
    if current_user.profile != "administrator"
      flash[:alert] = "Você não possui permissão."
      return redirect_to root_path
    end
  end

  def update
    if @transport_mode.update(transport_mode_params)
      flash[:notice] = "Modalidade de Transporte atualizada com sucesso!"
      redirect_to transport_mode_path(@transport_mode.id)
    else
      flash.now[:notice] = "Não foi possível atualizar a Modalidade de Transporte."
      render 'edit'
    end
  end

  def active
    if current_user.profile != "administrator"
      flash[:alert] = "Você não possui permissão."
      return redirect_to root_path
    end
    @transport_mode.active!
    flash[:notice] = "Modalidade de Transporte ativada."
    redirect_to @transport_mode
  end
  def inactive
    if current_user.profile != "administrator"
      flash[:alert] = "Você não possui permissão."
      return redirect_to root_path
    end
    @transport_mode.inactive!
    flash[:notice] = "Modalidade de Transporte desativada."
    redirect_to @transport_mode
  end

  private
  def set_transport_mode
    @transport_mode = TransportMode.find(params[:id])
  end
  def transport_mode_params
    transport_mode_params = params.require(:transport_mode).permit(:name, :minimum_distance, :maximum_distance, 
                                                                :minimum_weight, :maximum_weight, :fixed_value)
  end
end