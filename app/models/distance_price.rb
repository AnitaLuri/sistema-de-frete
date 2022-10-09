class DistancePrice < ApplicationRecord
  belongs_to :transport_mode

  validates :initial_distance, :ending_distance, :price, presence: true

  validates :initial_distance, comparison: { less_than: :ending_distance}
end
