require 'rails_helper'

RSpec.describe ServiceOrder, type: :model do
  context '#delivery_was_late?' do 
    it 'true when delvery_date exceeds started service order due_date' do 
      service_order = FactoryBot.create(:service_order, status: :in_progress, distance: 80, package_weight: 20)
      trans_mod = FactoryBot.create(:transport_modality, maximum_distance: 100, maximum_weight: 25)                                                           
      vehicle = FactoryBot.create(:vehicle, transport_modality: trans_mod)
      StartedServiceOrder.create!(service_order: service_order, vehicle: vehicle,
                                  transport_modality: trans_mod, due_date: 24.0,
                                  value: 10) 

      finished_so = FinishedServiceOrder.new(service_order: service_order, delivery_date: 3.days.from_now)

      expect(finished_so.delivery_was_late?).to be_truthy
    end

    it 'false when delvery_date respects started service order due_date' do 
      service_order = FactoryBot.create(:service_order, status: :in_progress, distance: 80, package_weight: 20)
      trans_mod = FactoryBot.create(:transport_modality, maximum_distance: 100, maximum_weight: 25)                                                           
      vehicle = FactoryBot.create(:vehicle, transport_modality: trans_mod)
      StartedServiceOrder.create!(service_order: service_order, vehicle: vehicle,
                                  transport_modality: trans_mod, due_date: 72.0,
                                  value: 10) 

      finished_so = FinishedServiceOrder.new(service_order: service_order, delivery_date: 1.day.from_now)

      expect(finished_so.delivery_was_late?).to be_falsy
    end
  end
end