class FinishedServiceOrder < ApplicationRecord
  belongs_to :service_order
  has_one :lateness_explanation

  enum :status, { in_time: 0, late: 10 }

  def delivery_was_late?
    started_so = self.service_order.started
    self.delivery_date > (started_so.created_at + started_so.due_date.hours)
  end
end
