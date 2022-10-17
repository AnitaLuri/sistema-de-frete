class Deadline < ApplicationRecord
  belongs_to :transport_mode
  
  validates :start, comparison: { less_than: :limit}
  validates :limit, :time, presence: true
  validates :time, numericality: { greater_than: 11 }
end
