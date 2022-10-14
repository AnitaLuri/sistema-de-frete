class StartedOrder < ApplicationRecord
  belongs_to :service_order
  belongs_to :transport_mode

  enum status: { progress: 0, concluded: 9}


end
