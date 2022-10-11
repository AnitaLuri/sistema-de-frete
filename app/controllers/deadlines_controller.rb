class DeadlinesController < ApplicationController
  before_action :authenticate_user!

  def index
    @deadlines = Deadline.all
  end

  def new
    @deadline = Deadline.new()
    @transport_modes = TransportMode.all
    if current_user.profile != "administrator"
      flash[:alert] = "Você não possui permissão."
      return redirect_to root_path
    end
  end
  def create
    @deadline = Deadline.new(deadline_params)
    if @deadline.save()
      flash[:notice] = "Prazo de Entrega cadastrado com sucesso!"
      redirect_to deadlines_path
    else
      @transport_modes = TransportMode.all
      flash.now[:notice] = "Prazo de Entrega não cadastrado."
      render 'new'
    end
  end

  def edit
    if current_user.administrator?
      @deadline = Deadline.find(params[:id])
      @transport_modes = TransportMode.all
    else
      flash[:alert] = "Você não possui permissão."
      return redirect_to root_path
    end
  end
  def update
    @deadline = Deadline.find(params[:id])
    if @deadline.update(deadline_params)
      flash[:notice] = "Prazo de Entrega atualizado com sucesso!"
      redirect_to deadlines_path
    else
      @transport_modes = TransportMode.all
      flash.now[:notice] = "Não foi possível atualizar prazo de entrega."
      render 'new'
    end
  end

  private
  def deadline_params
    deadline_params = params.require(:deadline).permit(:start, :limit, :time, :transport_mode_id)
  end
end