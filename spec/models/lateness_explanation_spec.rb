require 'rails_helper'

RSpec.describe ServiceOrder, type: :model do
  context '#valid?' do 
    it 'false when justification is empty' do 
      service_order = FactoryBot.create(:service_order)
      finished_so = FinishedServiceOrder.new(service_order: service_order, delivery_date: Date.today)

      lateness_explanation = LatenessExplanation.new(justification: nil, finished_service_order: finished_so)

      expect(lateness_explanation).not_to be_valid
    end

    it 'false when belonging finished_service_order is empty' do 
      lateness_explanation = LatenessExplanation.new(
                                                      justification: 'Comi muita manga',
                                                      finished_service_order: nil
                                                    )

      expect(lateness_explanation).not_to be_valid
    end
  end
end