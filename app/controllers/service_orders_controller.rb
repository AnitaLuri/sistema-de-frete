class ServiceOrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @service_orders = ServiceOrder.all
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

  def progress
    @service_order = ServiceOrder.find(params[:id])
    @transport_modes = TransportMode.where(['minimum_distance <= ? and maximum_distance >= ? and 
                                          minimum_weight <= ? and maximum_weight >= ?',
                                          @service_order.distance, @service_order.distance, 
                                          @service_order.weight, @service_order.weight])  
  end
  def start
    @service_order = ServiceOrder.find(params[:id])
    @service_order.progress!
    @service_order.update(service_order_params)

    flash[:notice] = "Ordem de Serviço iniciada com sucesso!"
    redirect_to start_service_order_path 
  end

  private
  def service_order_params
    service_order_params = params.require(:service_order).permit(:code, :from, :to, :distance, :recipient,
                                          :product_code, :width, :height, :depth, :weight, :status, :transport_mode_id)
  end
end