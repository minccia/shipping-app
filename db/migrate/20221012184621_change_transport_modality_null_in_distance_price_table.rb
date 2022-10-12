class ChangeTransportModalityNullInDistancePriceTable < ActiveRecord::Migration[7.0]
  def change
    change_column_null :distance_price_tables, :transport_modality_id, true
  end
end
