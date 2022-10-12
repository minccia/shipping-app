class DistancePriceTable < ApplicationRecord
  belongs_to :transport_modality, dependent: :destroy
  has_many :table_entries, dependent: :nullify

  after_create :ensure_table_has_at_least_one_entry

  private 

  def ensure_table_has_at_least_one_entry 
    if self.table_entries.empty? 
      TableEntry.create!(first_interval: 0, second_interval: 0, price: 0.0, distance_price_table: self)
    end
  end
end
