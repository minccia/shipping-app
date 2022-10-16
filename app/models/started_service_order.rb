class StartedServiceOrder < ApplicationRecord
  belongs_to :vehicle
  belongs_to :transport_modality
  belongs_to :service_order
end
