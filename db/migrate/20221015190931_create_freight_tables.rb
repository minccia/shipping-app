class CreateFreightTables < ActiveRecord::Migration[7.0]
  def change
    create_table :freight_tables do |t|
      t.references :transport_modality, null: false, foreign_key: true

      t.timestamps
    end
  end
end
