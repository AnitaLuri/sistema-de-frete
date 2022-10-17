class StartedOrdersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :included, :concluded]

  def index
    @started_orders = StartedOrder.all
  end
  
  def show
    @started_order = StartedOrder.find(params[:id])
  end

  def new
    @service_order = ServiceOrder.find(params[:service_order_id])
    @transport_modes = TransportMode.active.available(@service_order.distance, @service_order.weight) 
    @started_order = StartedOrder.new()
  end
  def create
    @started_order = StartedOrder.new(started_order_params)
    @service_order = ServiceOrder.find(params[:service_order_id])
    @started_order.service_order = @service_order
    @vehicles = Vehicle.active.where(["transport_mode_id = ?", @started_order.transport_mode_id, ])
    if @vehicles.empty?
      redirect_to new_service_order_started_order_path(service_order_id: @service_order.id)
      flash[:notice] = "Nenhum veículo disponível no momento para essa Modalidade, por favor selecione outra"
    else
      @vehicle = @vehicles.last
      @vehicle.operation!
      @started_order.vehicle = @vehicle
      @started_order.delivery_time = @started_order.transport_mode.calculate_deadline(@service_order.distance)
      @started_order.total_value = @started_order.transport_mode.value_total(@service_order.weight, @service_order.distance)
      @service_order.progress!
      if @started_order.save
        redirect_to service_order_started_order_path(@service_order, @started_order)
      else
        flash[:notice] = 'Prazo de entrega não foi cadastrado para essa Modalidade de Transporte.'
        redirect_to new_service_order_started_order_path(service_order_id: @service_order.id)
      end
    end
  end

  def included
    @started_order = StartedOrder.find(params[:started_order_id])
    @service_order = ServiceOrder.find(params[:service_order_id])
    @started_order.delivery_day = Time.zone.today 

    days = (@started_order.delivery_time)/24
    maximum_time = (@started_order.created_day) + days
    if @started_order.delivery_day > maximum_time 
      @started_order.delayed!
    else
      @started_order.concluded!
    end
    @started_order.vehicle.active!
    @service_order.closed!
  end
  def concluded 
    @started_order = StartedOrder.find(params[:started_order_id])
    @service_order = ServiceOrder.find(params[:service_order_id])
    @started_order.update!(comment: params[:comment])

    redirect_to service_orders_path
  end


  private
  def started_order_params
    started_order_params = params.require(:started_order).permit(:service_order_id, :transport_mode_id, :vehicle_id,
                                                                 :delivery_time, :total_value, :created_day, :comment, :status)
  end
end