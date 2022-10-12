class CreateWeightPriceLines < ActiveRecord::Migration[7.0]
  def change
    create_table :weight_price_lines do |t|
      t.references :weight_price_table, null: false, foreign_key: true
      t.integer :first_interval
      t.integer :second_interval
      t.float :price
      t.timestamps
    end
  end
end
