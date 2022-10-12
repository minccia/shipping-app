class ChangeTransportModalityNullInPriceTable < ActiveRecord::Migration[7.0]
  def change
    change_column_null :weight_price_tables, :transport_modality_id, true
  end
end
