class WeightPriceTable < ApplicationRecord
  belongs_to :transport_modality, dependent: :destroy
  has_many :table_entries, dependent: :nullify

end
