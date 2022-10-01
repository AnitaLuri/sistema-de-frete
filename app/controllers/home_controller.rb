class HomeController < ApplicationController
  def index
    @transport_modes = TransportMode.all
  end
end