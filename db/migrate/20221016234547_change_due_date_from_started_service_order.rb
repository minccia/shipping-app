class ChangeDueDateFromStartedServiceOrder < ActiveRecord::Migration[7.0]
  def change
    change_column :started_service_orders, :due_date, :integer
  end
end
