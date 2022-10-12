class CreatePriceLines < ActiveRecord::Migration[7.0]
  def change
    create_table :price_lines do |t|
      t.integer :first_interval
      t.integer :second_interval
      t.float :price
      t.references :distance_price_table, null: false, foreign_key: true
      t.references :weight_price_table, null: false, foreign_key: true

      t.timestamps
    end
  end
end
