class CreateFinishedServiceOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :finished_service_orders do |t|
      t.references :service_order, null: false, foreign_key: true
      t.date :delivery_date

      t.timestamps
    end
  end
end
