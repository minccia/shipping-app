class TableEntry < ApplicationRecord
  belongs_to :distance_price_table, optional: true 
  belongs_to :weight_price_table, optional: true
  belongs_to :freight_table, optional: true

  validates :first_interval, :second_interval, :value, presence: true

  def fetch_table
    if self.weight_price_table.nil? && self.freight_table.nil? 
      self.distance_price_table 
    
    elsif self.distance_price_table.nil? && self.freight_table.nil? 
      self.weight_price_table 
    
    else  
      self.freight_table
    end
  end
end
