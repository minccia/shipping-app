class RenameMinimumWeightFromTransportModality < ActiveRecord::Migration[7.0]
  def change
    rename_column :transport_modalities, :minium_weight, :minimum_weight
  end
end
