class TransportMode < ApplicationRecord
  validates :name, :minimum_distance, :maximum_distance, :minimum_weight, 
            :maximum_weight, :fixed_value, presence: true

  validates :name, uniqueness: true
end
