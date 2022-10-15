class DropFreightTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :freight_tables
  end
end
