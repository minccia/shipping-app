class TransportModality < ApplicationRecord
  has_many :vehicles
  validates :name, :maximum_distance, :maximum_weight, :fee, presence: true
end
