class TransportMode < ApplicationRecord
  has_many :vehicles
  has_many :weight_prices
  has_many :distance_prices
  has_many :deadlines
  has_many :service_orders
  
  validates :name, :minimum_distance, :maximum_distance, :minimum_weight, 
            :maximum_weight, :fixed_value, presence: true
  validates :name, uniqueness: true

  enum status: { active: 0, inactive: 5 }
end
