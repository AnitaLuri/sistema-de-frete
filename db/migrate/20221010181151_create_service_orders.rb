class CreateServiceOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :service_orders do |t|
      t.string :code
      t.string :from
      t.string :to
      t.integer :distance
      t.string :product_code
      t.integer :width
      t.integer :height
      t.integer :depth
      t.integer :weight
      t.string :recipient
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
