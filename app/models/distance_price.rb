class DistancePrice < ApplicationRecord
  belongs_to :transport_mode
  
  validates :initial_distance, comparison: { less_than: :ending_distance}
  validates  :ending_distance, :price, presence: true
end
