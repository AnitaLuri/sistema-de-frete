class ServiceOrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @service_orders = ServiceOrder.all
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

  def show
    @service_order = ServiceOrder.find(params[:id])
  end


  private
  def service_order_params
    service_order_params = params.require(:service_order).permit(:code, :from, :to, :distance, :recipient,
                                          :product_code, :width, :height, :depth, :weight, :status)
  end
end