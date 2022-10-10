class Deadline < ApplicationRecord
  belongs_to :transport_mode

  validates :start, :limit, :time, presence: true
  validates :start, comparison: { less_than: :limit}
end
