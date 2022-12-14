class CreateVehicles < ActiveRecord::Migration[7.0]
  def change
    create_table :vehicles do |t|
      t.string :license_plate
      t.string :brand_name
      t.string :type
      t.string :fabrication_year
      t.string :maximum_capacity
      t.integer :status
      t.references :transport_modality

      t.timestamps
    end
  end
end
