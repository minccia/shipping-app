require 'rails_helper'

describe 'app/models/freight.rb' do 
  context '#can_execute_service_order?' do 
    it 'true when service order distance and package weight respect the limit of transport modality' do 
      trans_mod = TransportModality.create!(name: 'Expresso', 
                                      maximum_distance: 100,
                                      maximum_weight: 25,
                                      fee: 59.9)
                                      
      FactoryBot.create(:table_entry, weight_price_table: trans_mod.weight_price_table)
      FactoryBot.create(:table_entry, distance_price_table: trans_mod.distance_price_table)
      FactoryBot.create(:table_entry, freight_table: trans_mod.freight_table)

      so = FactoryBot.create(:service_order, package_weight: 20, distance: 80)

      expect(trans_mod.can_execute_service_order?(so)).to be_truthy
    end

    it 'false when service order distance and package weight are higher than the limit of transport modality' do 
      trans_mod = TransportModality.create!(name: 'Expresso', 
                                      maximum_distance: 100,
                                      maximum_weight: 25,
                                      fee: 59.9)

      so = FactoryBot.create(:service_order, package_weight: 500, distance: 1500)

      expect(trans_mod.can_execute_service_order?(so)).to be_falsy
    end
  end
2
  context '#so_execution_price' do 
    it 'correct when transport modality can execute service order' do 
      trans_mod = TransportModality.create!(name: 'Expresso', 
                                      maximum_distance: 100,
                                      maximum_weight: 25,
                                      fee: 1)

      so = FactoryBot.create(:service_order, distance: 10, package_weight: 2)
      TableEntry.create!(first_interval: 0, second_interval: 10, value: 5, weight_price_table_id: trans_mod.weight_price_table.id)
      TableEntry.create!(first_interval: 11, second_interval: 20, value: 10, weight_price_table_id: trans_mod.weight_price_table.id)
      TableEntry.create!(first_interval: 21, second_interval: 30, value: 1.5, weight_price_table_id: trans_mod.weight_price_table.id)
      TableEntry.create!(first_interval: 31, second_interval: 40, value: 2.0, weight_price_table_id: trans_mod.weight_price_table.id)
      TableEntry.create!(first_interval: 0, second_interval: 20, value: 5, distance_price_table_id: trans_mod.distance_price_table.id)
      TableEntry.create!(first_interval: 20, second_interval: 40, value: 10, distance_price_table_id: trans_mod.distance_price_table.id)
      TableEntry.create!(first_interval: 40, second_interval: 60, value: 15, distance_price_table_id: trans_mod.distance_price_table.id)
      TableEntry.create!(first_interval: 60, second_interval: 80, value: 20, distance_price_table_id: trans_mod.distance_price_table.id)    
      
      expect(trans_mod.so_execution_price(so)).to eq 56.0
    end
  end    

  context '#so_execution_due_date' do 
    it 'correct when transport modality can execute service order' do 
      trans_mod = TransportModality.create!(name: 'Expresso', 
                                      maximum_distance: 100,
                                      maximum_weight: 25,
                                      fee: 1)

      so = FactoryBot.create(:service_order, distance: 10, package_weight: 2)
      TableEntry.create!(first_interval: 0, second_interval: 50, value: 24, freight_table_id: trans_mod.freight_table.id)
      TableEntry.create!(first_interval: 50, second_interval: 100, value: 72, freight_table_id: trans_mod.freight_table.id)

      expect(trans_mod.so_execution_due_date(so)).to eq 24.0
    end
  end
end