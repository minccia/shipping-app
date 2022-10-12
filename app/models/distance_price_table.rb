class DistancePriceTable < ApplicationRecord
  belongs_to :transport_modality
  has_many :price_lines

end
