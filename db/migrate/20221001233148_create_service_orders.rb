class CreateServiceOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :service_orders do |t|
      t.string :sender_full_address
      t.string :sender_zip_code
      t.string :package_code
      t.integer :package_height
      t.integer :package_width
      t.integer :package_depth
      t.integer :package_weight
      t.string :receiver_name
      t.string :receiver_full_address
      t.string :receiver_zip_code
      t.integer :distance

      t.timestamps
    end
  end
end
