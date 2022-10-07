class CreateTransportModalities < ActiveRecord::Migration[7.0]
  def change
    create_table :transport_modalities do |t|
      t.string :name
      t.integer :minimum_distance
      t.integer :maximum_distance
      t.integer :minium_weight
      t.integer :maximum_weight
      t.float :fee
      t.boolean :active

      t.timestamps
    end
  end
end
