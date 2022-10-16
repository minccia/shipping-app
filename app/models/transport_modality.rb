class TransportModality < ApplicationRecord
  has_many :vehicles
  has_one :distance_price_table, dependent: :nullify
  has_one :weight_price_table, dependent: :nullify
  has_one :freight_table, dependent: :nullify

  before_save :ensure_transport_modality_has_tables
  validates :name, :maximum_distance, :maximum_weight, :fee, presence: true

  def can_execute_service_order?(so)
    Freight::Calculator.new(self, so).can_execute_service_order?
  end 

  def so_execution_price(so)
    Freight::Calculator.new(self, so).total_freight_price
  end

  def so_execution_due_date(so)
    Freight::Calculator.new(self, so).calculate_due_date
  end
  
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
