class AddCreatedDateToStartedOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :started_orders, :created_day, :date
  end
end
