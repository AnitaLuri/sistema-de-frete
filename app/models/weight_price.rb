class WeightPrice < ApplicationRecord
  belongs_to :transport_mode

  validates :initial_weight, comparison: { less_than: :ending_weight}
  validates :ending_weight, :km_value, presence: true
  validates :km_value, numericality: { greater_than: 0 }
end
