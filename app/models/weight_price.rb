class WeightPrice < ApplicationRecord
  belongs_to :transport_mode

  validates :initial_weight, :ending_weight, :km_value, presence: true

  validates :initial_weight, comparison: { less_than: :ending_weight}
  
end
