class AddColumnToStartedOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :started_orders, :delivery_day, :date
    add_column :started_orders, :comment, :string
  end
end
