class DropWeightPriceLines < ActiveRecord::Migration[7.0]
  def change
    drop_table :weight_price_lines
  end
end
