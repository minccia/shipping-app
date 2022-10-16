class CreateStartedServiceOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :started_service_orders do |t|
      t.float :due_date
      t.float :value
      t.references :vehicle, null: true, foreign_key: true
      t.references :transport_modality, true: false, foreign_key: true
      t.references :service_order, null: true, foreign_key: true

      t.timestamps
    end
  end
end
