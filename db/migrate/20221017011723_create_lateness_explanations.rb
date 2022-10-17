class CreateLatenessExplanations < ActiveRecord::Migration[7.0]
  def change
    create_table :lateness_explanations do |t|
      t.string :justification

      t.timestamps
    end
  end
end
