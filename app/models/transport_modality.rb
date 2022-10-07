class TransportModality < ApplicationRecord
  validates :name, :maximum_distance, :maximum_weight, :fee, presence: true
end
