class Vehicle < ApplicationRecord
  belongs_to :transport_modality

  validates :license_plate, :brand_name, :vehicle_type, :fabrication_year, :maximum_capacity, presence: true

  enum :status, { available: 0, in_operation: 1, on_maintenance: 2 }
end
