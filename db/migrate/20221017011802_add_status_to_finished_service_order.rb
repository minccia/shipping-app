class AddStatusToFinishedServiceOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :finished_service_orders, :status, :integer, default: 0
  end
end
