class ChangeNullFromFreightTable < ActiveRecord::Migration[7.0]
  def change
    change_column_null :freight_tables, :transport_modality_id, true
  end
end
