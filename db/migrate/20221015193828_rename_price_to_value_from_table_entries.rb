class RenamePriceToValueFromTableEntries < ActiveRecord::Migration[7.0]
  def change
    rename_column :table_entries, :price, :value
  end
end
