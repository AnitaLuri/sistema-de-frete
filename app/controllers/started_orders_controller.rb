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
    @service_order = ServiceOrder.find(params[:service_order_id])
    @service_order.progress!
    @started_order = StartedOrder.new(started_order_params)
    @started_order.service_order = @service_order
    @started_order.save

    redirect_to @service_order
  end


  private
  def started_order_params
    started_order_params = params.require(:started_order).permit(:service_order_id, :transport_mode_id, 
                                                                  :total_value, :status)
  end
end