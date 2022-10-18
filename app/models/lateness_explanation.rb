class LatenessExplanation < ApplicationRecord
  belongs_to :finished_service_order

  validates :justification, presence: true
end
 