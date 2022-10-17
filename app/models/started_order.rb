class StartedOrder < ApplicationRecord
  belongs_to :service_order
  belongs_to :transport_mode
  belongs_to :vehicle

  validates :delivery_time, :total_value, presence: true
 
  enum status: { progress: 0, concluded: 5, delayed: 9}
end
