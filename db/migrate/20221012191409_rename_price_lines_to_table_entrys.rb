class RenamePriceLinesToTableEntrys < ActiveRecord::Migration[7.0]
  def change
    rename_table :price_lines, :table_entries
  end
end
