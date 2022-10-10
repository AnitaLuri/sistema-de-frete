class TransportMode < ApplicationRecord
  validates :name, :minimum_distance, :maximum_distance, :minimum_weight, 
            :maximum_weight, :fixed_value, presence: true

  validates :name, uniqueness: true

  has_many :vehicles
  has_many :weight_prices
  has_many :distance_prices
  has_many :deadlines

  enum status: { active: 0, inactive: 5 }
end
