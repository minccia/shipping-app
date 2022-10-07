class UpdateStatusDefaultToActiveTransportModalities < ActiveRecord::Migration[7.0]
  def change
    change_column_default :transport_modalities, :active, from: nil, to: true
  end
end
