class TableEntry < ApplicationRecord
  belongs_to :distance_price_table, optional: true 
  belongs_to :weight_price_table, optional: true
  belongs_to :freight_table, optional: true

  validates :first_interval, :second_interval, :value, presence: true

  def fetch_price_table 
    self.weight_price_table.nil? ? self.distance_price_table : self.weight_price_table
  end

  def hours_and_days
    day_quantity = self.value/24
    "#{self.value} #{  'units.hours' } (#{day_quantity} #} #{ t 'units.days', count: day_quantity })"
  end
end
