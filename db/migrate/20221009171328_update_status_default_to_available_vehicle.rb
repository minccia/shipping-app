class UpdateStatusDefaultToAvailableVehicle < ActiveRecord::Migration[7.0]
  def change
    change_column_default :vehicles, :status, from: nil, to: 'available'
  end
end
