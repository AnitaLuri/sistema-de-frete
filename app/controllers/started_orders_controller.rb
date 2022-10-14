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
    @service_order.progress!
    @started_order.service_order = @service_order
    @vehicles = Vehicle.active.where(["transport_mode_id = ?", @started_order.transport_mode_id, ])
    

    @vehicle = @vehicles.last
    @vehicle.operation!
    @started_order.vehicle_id = @vehicle
    
   
    #incluir o veiculo 
    #mudar o status do veiculo
    #incluir o prazo de entrega
    #incluir o valor total

    @started_order.save

    redirect_to @service_order
  end


  private
  def started_order_params
    started_order_params = params.require(:started_order).permit(:service_order_id, :transport_mode_id, 
                                                                :vehicle_id, :total_value, :status)
  end
end