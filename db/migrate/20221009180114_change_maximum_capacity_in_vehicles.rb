class ChangeMaximumCapacityInVehicles < ActiveRecord::Migration[7.0]
  def change
    change_column :vehicles, :maximum_capacity, :integer
  end
end
