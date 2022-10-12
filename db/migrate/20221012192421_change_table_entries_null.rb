class ChangeTableEntriesNull < ActiveRecord::Migration[7.0]
  def change
    change_column_null :table_entries, :distance_price_table_id, true 
    change_column_null :table_entries, :weight_price_table_id, true 
  end
end
