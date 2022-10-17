class HomeController < ApplicationController
  def index
    @transport_modes = TransportMode.all.order(name: :asc)
  end

end