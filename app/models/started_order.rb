class StartedOrder < ApplicationRecord
  belongs_to :service_order
  belongs_to :transport_mode
  belongs_to :vehicle

  validates :delivery_time, :total_value, :comment, presence: true
  validates :delivery_time, numericality: { greater_than: 11 }
  validates :total_value, numericality: { greater_than: 0 }
  
  

  enum status: { started: 0, concluded: 5, delayed: 9}

  before_validation :generate_date, on: :create
  before_validation :validate_comment, on: :create

  def generate_date
    self.created_day = Time.zone.today 
  end
  def validate_comment
    self.comment = 'Ordem de Serviço no prazo, ainda não encerrada!'
  end
end
