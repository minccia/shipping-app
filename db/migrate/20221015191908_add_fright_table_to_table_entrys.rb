class AddFrightTableToTableEntrys < ActiveRecord::Migration[7.0]
  def change
    add_reference :table_entries, :freight_table, null: true, foreign_key: true
  end
end
