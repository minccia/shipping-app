class PriceLine < ApplicationRecord
  belongs_to :distance_price_table, optional: true 
  belongs_to :weight_price_table, optional: true
end
