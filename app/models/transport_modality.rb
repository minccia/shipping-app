class TransportModality < ApplicationRecord
  has_many :vehicles
  has_one :distance_price_table
  has_one :weight_price_table

  before_validation :ensure_transport_modality_has_price_tables
  validates :name, :maximum_distance, :maximum_weight, :fee, presence: true

  private 
    def ensure_transport_modality_has_price_tables
      if self.distance_price_table.nil?
        self.distance_price_table = DistancePriceTable.create!(transport_modality: self)
      end
      if self.weight_price_table.nil?
        self.weight_price_table = WeightPriceTable.create!(transport_modality: self)
      end
    end

end
