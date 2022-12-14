class ServiceOrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :create, :included, :concluded]

  def index
    @service_orders = ServiceOrder.all
    @started_orders = StartedOrder.all
  end

  def show
    @service_order = ServiceOrder.find(params[:id])
  end

  def new
    if current_user.administrator?
      @service_order = ServiceOrder.new()
    else
      flash[:alert] = "Você não possui permissão."
      return redirect_to root_path
    end
  end
  def create
    @service_order = ServiceOrder.new(service_order_params)
    if @service_order.save()
      flash[:notice] = "Ordem de Serviço registrada com sucesso!"
      redirect_to @service_order
    else
      flash.now[:notice] = "Ordem de Serviço não registrada."
      render 'new'
    end
  end

  def edit
    if current_user.administrator?
      @service_order = ServiceOrder.find(params[:id])
      @transport_modes = TransportMode.all.order(name: :asc)
    else
      flash[:alert] = "Você não possui permissão."
      return redirect_to root_path
    end
  end
  def update
    @service_order = ServiceOrder.find(params[:id])
    if @service_order.update(service_order_params)
      flash[:notice] = "Ordem de Serviço atualizado com sucesso!"
      redirect_to service_order_path
    else
      @transport_modes = TransportMode.all.order(name: :asc)
      flash.now[:notice] = "Não foi possível atualizar Ordem de Serviço."
      render 'new'
    end
  end

  def search
    @search = params['query']
    @service_orders = ServiceOrder.where("code LIKE ?", "%#{@search}%")
    @started_orders = StartedOrder.all
  end

  
  private
  def service_order_params
    service_order_params = params.require(:service_order).permit(:code, :from, :to, :distance, :recipient,
                                          :product_code, :width, :height, :depth, :weight, :status, :transport_mode_id)
  end
end