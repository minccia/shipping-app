class FinishedServiceOrder < ApplicationRecord
  belongs_to :service_order
  has_one :lateness_explanation

  enum :status, { in_time: 0, late: 10 }

  def delivery_was_late?
    self.delivery_date.strftime("%d/%m/%Y") > self.service_order.started.due_date.hours.from_now.strftime("%d/%m/%Y")
  end
end
