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

  private
  def deadline_params
    deadline_params = params.require(:deadline).permit(:start, :limit, :time, :transport_mode_id)
  end
end