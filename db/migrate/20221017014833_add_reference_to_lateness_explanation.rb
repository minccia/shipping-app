class AddReferenceToLatenessExplanation < ActiveRecord::Migration[7.0]
  def change
    add_reference :lateness_explanations, :finished_service_order, null: true, foreign_key: true
  end
end
