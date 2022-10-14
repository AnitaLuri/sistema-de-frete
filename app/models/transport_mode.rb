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

  scope :available , -> (distance, weight) { where(['minimum_distance <= ? and maximum_distance >= ? and 
                                  minimum_weight <= ? and maximum_weight >= ?',
                                  distance, distance, 
                                  weight, weight])   }

  def calculate_weight_value(weight, distance)
    weight_value = 0
    weight_prices.each do |weight_price|
      if weight_price.initial_weight <= weight && weight_price.ending_weight >= weight 
        weight_value = (weight_price.km_value * distance)
      
      end
    end 
    weight_value
  end

  def calculate_distance_value(distance)
    distance_value = 0
    distance_prices.each do |distance_price|
      if distance_price.initial_distance <= distance && distance_price.ending_distance >= distance
        distance_value = distance_price.price
        distance_value
      end
    end
    distance_value
  end

  def calculate_deadline(distance)
    deadline_time = 0
    deadlines.each do |deadline|
      if deadline.start <= distance && deadline.limit >= distance 
        deadline_time = deadline.time
      end 
    end
    deadline_time
  end

  def value_total(weight, distance)
    fixed_value + calculate_weight_value(weight, distance) + calculate_distance_value(distance)
  end
end
