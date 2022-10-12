class DropDistancePriceLines < ActiveRecord::Migration[7.0]
  def change
    drop_table :distance_price_lines
  end
end
