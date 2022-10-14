class Vehicle < ApplicationRecord
  belongs_to :transport_mode

  validates :plate, :brand, :model, :year, :weight_limit, :status, presence: true
  validates :plate, uniqueness: true
  validates :plate, length: { is: 7 }
  validates :weight_limit, numericality: { greater_than: 0 }

  enum status: { active: 0, operation: 3, repair: 6, off: 9 }
end
