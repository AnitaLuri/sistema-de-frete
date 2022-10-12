class AddTransportModeToServiceOrder < ActiveRecord::Migration[7.0]
  def change
    add_reference :service_orders, :transport_mode, null: true, foreign_key: true
  end
end
