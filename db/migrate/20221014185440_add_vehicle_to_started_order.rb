class AddVehicleToStartedOrder < ActiveRecord::Migration[7.0]
  def change
    add_reference :started_orders, :vehicle, null: true, foreign_key: true
  end
end
