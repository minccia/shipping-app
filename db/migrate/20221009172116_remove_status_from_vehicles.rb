class RemoveStatusFromVehicles < ActiveRecord::Migration[7.0]
  def change
    remove_column :vehicles, :status
  end
end
