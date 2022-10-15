class StartedOrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @started_orders = StartedOrder.all
  end
  
  def show
    @started_order = StartedOrder.find(params[:id])
  end

  def new
    @service_order = ServiceOrder.find(params[:service_order_id])
    @started_order = StartedOrder.new()
    @transport_modes = TransportMode.active.available(@service_order.distance, @service_order.weight) 
  end
  def create
    @started_order = StartedOrder.new(started_order_params)
    @service_order = ServiceOrder.find(params[:service_order_id])
    @started_order.service_order = @service_order

    @vehicles = Vehicle.active.where(["transport_mode_id = ?", @started_order.transport_mode_id, ])
    @vehicle = @vehicles.last
    @started_order.vehicle = @vehicle
    @vehicle.operation!
    @started_order.delivery_time = @started_order.transport_mode.calculate_deadline(@service_order.distance)
    @started_order.total_value = @started_order.transport_mode.value_total(@service_order.weight, @service_order.distance)

    #incluir o prazo de entrega
    #incluir o valor total
    @service_order.progress!
    @started_order.save

    redirect_to @service_order
  end


  private
  def started_order_params
    started_order_params = params.require(:started_order).permit(:service_order_id, :transport_mode_id, 
                                                                :vehicle_id, :delivery_time, :total_value, :status)
  end
end