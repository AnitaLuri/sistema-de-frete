class CreateWeightPrices < ActiveRecord::Migration[7.0]
  def change
    create_table :weight_prices do |t|
      t.integer :initial_weight
      t.integer :ending_weight
      t.decimal :km_value
      t.references :transport_mode, null: false, foreign_key: true

      t.timestamps
    end
  end
end
