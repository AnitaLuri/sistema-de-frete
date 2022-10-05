class Vehicle < ApplicationRecord
  belongs_to :transport_mode

  enum status: { available: 0, operation: 3, repair: 6, off: 9 }
end
