class CreateDistancePrices < ActiveRecord::Migration[7.0]
  def change
    create_table :distance_prices do |t|
      t.integer :initial_distance
      t.integer :ending_distance
      t.decimal :price
      t.references :transport_mode, null: false, foreign_key: true

      t.timestamps
    end
  end
end
