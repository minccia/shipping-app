require 'rails_helper'

RSpec.describe StartedServiceOrder, type: :model do
  context '#valid?' do 
    it 'false when due_date is empty' do 
      trans_mod = FactoryBot.create(:transport_modality)
      vehicle = FactoryBot.create(:vehicle, transport_modality: trans_mod)
      service_order = FactoryBot.create(:service_order)
      started_so = StartedServiceOrder.new(
                                           due_date: nil, 
                                           vehicle: vehicle, 
                                           transport_modality: trans_mod,
                                           service_order: service_order,
                                           value: 10.0)
    
      started_so.save 

      expect(started_so).not_to be_valid 
    end

    it 'false when value is empty' do 
      trans_mod = FactoryBot.create(:transport_modality)
      vehicle = FactoryBot.create(:vehicle, transport_modality: trans_mod)
      service_order = FactoryBot.create(:service_order)
      started_so = StartedServiceOrder.new(
                                           due_date: 72.0, 
                                           vehicle: vehicle, 
                                           transport_modality: trans_mod,
                                           service_order: service_order,
                                           value: nil)
    
      started_so.save 

      expect(started_so).not_to be_valid 
    end

    it 'false when vehicle is empty' do 
      trans_mod = FactoryBot.create(:transport_modality)
      service_order = FactoryBot.create(:service_order)
      started_so = StartedServiceOrder.new(
                                           due_date: 72.0, 
                                           vehicle: nil, 
                                           transport_modality: trans_mod,
                                           service_order: service_order,
                                           value: 10)
    
      started_so.save 

      expect(started_so).not_to be_valid 
    end

    it 'false when transport_modality is empty' do 
      vehicle = FactoryBot.create(:vehicle)
      service_order = FactoryBot.create(:service_order)
      started_so = StartedServiceOrder.new(
                                           due_date: 72.0, 
                                           vehicle: vehicle, 
                                           transport_modality: nil,
                                           service_order: service_order,
                                           value: nil)
    
      started_so.save 

      expect(started_so).not_to be_valid 
    end

    it 'false when belonging service_order is empty' do 
      trans_mod = FactoryBot.create(:transport_modality)
      vehicle = FactoryBot.create(:vehicle, transport_modality: trans_mod)
      
      started_so = StartedServiceOrder.new(
                                           due_date: 72.0, 
                                           vehicle: vehicle, 
                                           transport_modality: trans_mod,
                                           service_order: nil,
                                           value: nil)
    
      started_so.save 

      expect(started_so).not_to be_valid 
    end
  end
end