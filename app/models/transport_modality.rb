class TransportModality < ApplicationRecord
  has_many :vehicles
  has_one :distance_price_table, dependent: :nullify
  has_one :weight_price_table, dependent: :nullify
  has_one :freight_table, dependent: :nullify

  before_save :ensure_transport_modality_has_tables
  validates :name, :maximum_distance, :maximum_weight, :fee, presence: true

  private 
    def ensure_transport_modality_has_tables
      if self.distance_price_table.nil?
        self.distance_price_table = DistancePriceTable.create!(transport_modality: self)
      end
      if self.weight_price_table.nil?
        self.weight_price_table = WeightPriceTable.create!(transport_modality: self)
      end
      if self.freight_table.nil? 
        self.freight_table = FreightTable.create!(transport_modality: self)
      end
    end

  end
