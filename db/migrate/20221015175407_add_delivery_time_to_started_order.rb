class AddDeliveryTimeToStartedOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :started_orders, :delivery_time, :integer
  end
end
