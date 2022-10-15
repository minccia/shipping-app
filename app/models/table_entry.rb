class TableEntry < ApplicationRecord
  belongs_to :distance_price_table, optional: true 
  belongs_to :weight_price_table, optional: true
  belongs_to :freight_table, optional: true

  validates :first_interval, :second_interval, :value, presence: true

  def fetch_price_table 
    self.weight_price_table.nil? ? self.distance_price_table : self.weight_price_table
  end
end
