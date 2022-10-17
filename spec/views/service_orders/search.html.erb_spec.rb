require 'rails_helper'

describe 'service_orders/search.html.erb' do 
  context 'User search for service orders on application nav' do 

    it 'with success' do 
      allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('ABCDE12345678')    
      so = FactoryBot.create(:service_order, created_at: Date.today)
      
      visit root_path 
      fill_in 'Buscar ordem de serviço', with: 'ABC'
      click_on 'Buscar'
  
      expect(page).to have_content 'Ordem de serviço <ABCDE12345678>'
      expect(page).to have_content "Data de início: #{ (Date.today).strftime("%d/%m/%Y") }"
    end

    it 'and the service order is in progress' do 
      allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('ABCDE12345678') 
      service_order = FactoryBot.create(
                                        :service_order, status: :in_progress,
                                        distance: 80, package_weight: 20, created_at: Date.today
                                      )

      trans_mod = TransportModality.create!(name: 'Ghetto', 
                                            maximum_distance: 100,
                                            maximum_weight: 25,
                                            fee: 12.9
                                          )
      vehicle = Vehicle.create!(
                                license_plate: 'ABC1D23',
                                brand_name: 'Fiat',
                                vehicle_type: 'Van',
                                fabrication_year: '2010',
                                maximum_capacity: '500',
                                transport_modality: trans_mod,
                                status: :in_operation
                              )
      TableEntry.create!(first_interval: 11, second_interval: 20, value: 0.50, weight_price_table_id: trans_mod.weight_price_table.id)
      TableEntry.create!(first_interval: 60, second_interval: 80, value: 20, distance_price_table_id: trans_mod.distance_price_table.id)                                         
      TableEntry.create!(first_interval: 50, second_interval: 100, value: 72, freight_table_id: trans_mod.freight_table.id)

      value = trans_mod.so_execution_price(service_order)
      due_date = trans_mod.so_execution_due_date(service_order)

      StartedServiceOrder.create!(service_order: service_order, vehicle: vehicle,
                                  transport_modality: trans_mod, due_date: due_date,
                                  value: value
                                )

      visit root_path 
      fill_in 'Buscar ordem de serviço', with: 'ABC'
      click_on 'Buscar'
      
      expect(page).to have_content 'Ordem de serviço <ABCDE12345678>'
      expect(page).to have_content "Data de início: #{ (Date.today).strftime("%d/%m/%Y") }"
      expect(page).to have_content "Veículo responsável: #{vehicle.license_plate}"
      expect(page).to have_content "Data estimada de entrega: #{service_order.started.due_date.hours.from_now.strftime("%d/%m/%Y")}"
    end

    it 'and the service order is finished' do 
      allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('ABCDE12345678') 
      service_order = FactoryBot.create(
                                        :service_order, status: :finished,
                                        distance: 80, package_weight: 20, created_at: Date.today
                                      )

      trans_mod = TransportModality.create!(name: 'Ghetto', 
                                            maximum_distance: 100,
                                            maximum_weight: 25,
                                            fee: 12.9
                                          )
      vehicle = Vehicle.create!(
                                license_plate: 'ABC1D23',
                                brand_name: 'Fiat',
                                vehicle_type: 'Van',
                                fabrication_year: '2010',
                                maximum_capacity: '500',
                                transport_modality: trans_mod,
                                status: :available
                              )
      TableEntry.create!(first_interval: 11, second_interval: 20, value: 0.50, weight_price_table_id: trans_mod.weight_price_table.id)
      TableEntry.create!(first_interval: 60, second_interval: 80, value: 20, distance_price_table_id: trans_mod.distance_price_table.id)                                         
      TableEntry.create!(first_interval: 50, second_interval: 100, value: 72, freight_table_id: trans_mod.freight_table.id)

      value = trans_mod.so_execution_price(service_order)
      due_date = trans_mod.so_execution_due_date(service_order)
 
      StartedServiceOrder.create!(
                                  service_order: service_order, vehicle: vehicle,
                                  transport_modality: trans_mod, due_date: due_date,
                                  value: value
                                )

      FinishedServiceOrder.create!(service_order: service_order, delivery_date: 4.days.from_now)

      visit root_path 
      fill_in 'Buscar ordem de serviço', with: 'ABC'
      click_on 'Buscar'
      
      expect(page).to have_content 'Ordem de serviço <ABCDE12345678>'
      expect(page).to have_content "Data de início: #{ (Date.today).strftime("%d/%m/%Y") }"
      expect(page).to have_content "Data de encerramento: #{ 4.days.from_now.strftime("%d/%m/%Y") }"
    end
  end
end