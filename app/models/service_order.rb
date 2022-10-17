class ServiceOrder < ApplicationRecord
  has_one :started_order
  has_many :transport_modes
  
  validates :code, :from, :to, :distance, :recipient, :product_code, :width, :height, :depth, 
            :weight, :status, presence: true
  validates :weight, :width, :height, :depth, numericality: { greater_than: 0 }

  enum status: { pending: 0, progress: 5, closed: 9}

  before_validation :generate_code, on: :create
  
  def generate_code
    self.code = SecureRandom.alphanumeric(15).upcase
  end
  
end
