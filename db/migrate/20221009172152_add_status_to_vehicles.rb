class AddStatusToVehicles < ActiveRecord::Migration[7.0]
  def change
    add_column :vehicles, :status, :integer, default: 'active'
  end
end
