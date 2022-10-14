class CreateStartedOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :started_orders do |t|
      t.references :service_order, null: false, foreign_key: true
      t.references :transport_mode, null: false, foreign_key: true
      t.decimal :total_value
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
