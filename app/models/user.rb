class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true

  enum profile: { regular: 0, administrator: 5, inactive: 9 }
end
