class StartedOrder < ApplicationRecord
  belongs_to :service_order
  belongs_to :transport_mode
  belongs_to :vehicle

  validates :delivery_time, :total_value, presence: true
  validates :delivery_time, numericality: { greater_than: 11 }

 
  enum status: { started: 0, concluded: 5, delayed: 9}

  before_validation :generate_date, on: :create

  def generate_date
    self.created_day = Time.zone.today 
  end
end
