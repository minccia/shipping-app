class DistancePriceTable < ApplicationRecord
  belongs_to :transport_modality
  has_many :distance_price_lines

  before_validation :ensure_table_has_price_lines

  private 

    def ensure_table_has_price_lines
      if self.distance_price_lines.nil?
        DistancePriceLine.create!(first_interval: 0, second_interval: 0, price: 0, distance_price_table: self)
      end
    end
end
