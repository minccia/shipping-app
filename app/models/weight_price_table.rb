class WeightPriceTable < ApplicationRecord
  belongs_to :transport_modality
  has_many :weight_price_lines

  before_validation :ensure_table_has_price_lines

  private 

    def ensure_table_has_price_lines
      if self.weight_price_lines.nil?
        WeightPriceLine.create!(first_interval: 0, second_interval: 0, price: 0, weight_price_table: self)
      end
    end
end
