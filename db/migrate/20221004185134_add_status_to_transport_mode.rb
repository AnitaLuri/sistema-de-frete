class AddStatusToTransportMode < ActiveRecord::Migration[7.0]
  def change
    add_column :transport_modes, :status, :integer, default: 0
  end
end
