require 'rails_helper'

describe 'service_orders/show.html.erb' do 
  let(:user) { FactoryBot.create(:user) }

  context 'User view pending service order details' do 
    it 'if authenticated' do 
      so = FactoryBot.create(:service_order)

      visit service_order_path(so.id)

      expect(current_path).to eq new_user_session_path
    end
    
    it 'reaching the details page' do 
      allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('ABCDE12345678')
      ServiceOrder.create(
                          sender_full_address: 'Av Das Palmas, 100',
                          sender_zip_code: '60334120',
                          package_height: 10, package_width: 10,
                          package_depth: 10, package_weight: 100,
                          receiver_name: 'Paola Dobrotto',
                          receiver_full_address: 'Av Das Laranjeiras, 500',
                          receiver_zip_code: '60334520',
                          distance: 100
                        )  

      login_as user, scope: :user                  
      visit root_path 
      click_on 'Ordens de serviço'
      click_on 'Ordem de serviço <ABCDE12345678>'

      expect(current_path).to eq service_order_path(ServiceOrder.last.id)
      expect(page).to have_content 'Endereço do remetente: Av Das Palmas, 100'
      expect(page).to have_content 'CEP do remetente: 60334-120'
      expect(page).to have_content 'Dimensões do pacote: 10 x 10 x 10 centímetros'
      expect(page).to have_content 'Peso do pacote: 100 gramas'
      expect(page).to have_content 'Nome do destinatário: Paola Dobrotto'
      expect(page).to have_content 'Endereço do destinatário: Av Das Laranjeiras, 500'
      expect(page).to have_content 'CEP do destinatário: 60334-520'
      expect(page).to have_content '100 metros'
    end

    it 'and return to home page' do
      so = FactoryBot.create(:service_order)
      
      login_as user, scope: :user
      visit service_order_path(so.id)
      click_on 'Início'
  
      expect(current_path).to eq root_path
    end
  end

  context 'User initiate service order' do 
    it 'through cotations section' do 
      service_order = FactoryBot.create(:service_order, distance: 80, package_weight: 20)
      trans_mod = TransportModality.create!(name: 'Ghetto', 
                                            maximum_distance: 100,
                                            maximum_weight: 25,
                                            fee: 12.9)
      TableEntry.create!(first_interval: 11, second_interval: 20, value: 0.50, weight_price_table_id: trans_mod.weight_price_table.id)
      TableEntry.create!(first_interval: 60, second_interval: 80, value: 20, distance_price_table_id: trans_mod.distance_price_table.id)                                         
      TableEntry.create!(first_interval: 50, second_interval: 100, value: 72, freight_table_id: trans_mod.freight_table.id)

      login_as user, scope: :user
      visit service_order_path(service_order.id)

      expect(page).to have_content 'Iniciar ordem de serviço'
      expect(page).to have_content 'Ghetto'
      expect(page).to have_content 'R$ 72,90'
      expect(page).to have_content '72 Horas (3 Dias)'
      expect(page).to have_content 'Selecione a forma de entrega'
    end

    it 'with success' do 
      service_order = FactoryBot.create(:service_order, distance: 80, package_weight: 20)
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
                                transport_modality: trans_mod
                              )
      TableEntry.create!(first_interval: 11, second_interval: 20, value: 0.50, weight_price_table_id: trans_mod.weight_price_table.id)
      TableEntry.create!(first_interval: 60, second_interval: 80, value: 20, distance_price_table_id: trans_mod.distance_price_table.id)                                         
      TableEntry.create!(first_interval: 50, second_interval: 100, value: 72, freight_table_id: trans_mod.freight_table.id)

      login_as user, scope: :user
      visit service_order_path(service_order.id)

      select 'Ghetto', from: 'Selecione a forma de entrega'
      click_on 'Enviar'

      expect(current_path).to eq service_order_path(service_order.id)
      expect(page).to have_content 'Ordem de serviço iniciada com sucesso'
      expect(page).to have_content 'Ordem de serviço em andamento'
      expect(page).to have_content 'Modalidade de transporte: Ghetto'
      expect(page).to have_content "Veículo responsável: #{vehicle.license_plate}"
      expect(page).to have_content "Data estimada de entrega: #{ 72.hours.from_now.strftime("%d/%m/%Y") }"
      expect(page).to have_content 'Valor: R$ 72,90'
    end

    it 'and there are no vehicles available' do
      service_order = FactoryBot.create(:service_order, distance: 80, package_weight: 20)
      trans_mod = TransportModality.create!(name: 'Ghetto', 
                                            maximum_distance: 100,
                                            maximum_weight: 25,
                                            fee: 12.9
                                          )
      vehicle = FactoryBot.create(:vehicle, transport_modality: trans_mod, status: :on_maintenance)

      TableEntry.create!(first_interval: 11, second_interval: 20, value: 0.50, weight_price_table_id: trans_mod.weight_price_table.id)
      TableEntry.create!(first_interval: 60, second_interval: 80, value: 20, distance_price_table_id: trans_mod.distance_price_table.id)                                         
      TableEntry.create!(first_interval: 50, second_interval: 100, value: 72, freight_table_id: trans_mod.freight_table.id)
  
      login_as user, scope: :user
      visit service_order_path(service_order.id)
  
      select 'Ghetto', from: 'Selecione a forma de entrega'
      click_on 'Enviar'

      expect(page).to have_content 'Não há veículos disponíveis na modalidade Ghetto para iniciar a ordem de serviço'
      expect(page).to have_content 'Iniciar ordem de serviço'
    end

    it 'and there are no entries on tables' do 
      service_order = FactoryBot.create(:service_order, distance: 80, package_weight: 20)
      trans_mod = TransportModality.create!(name: 'Ghetto', 
                                            maximum_distance: 100,
                                            maximum_weight: 25,
                                            fee: 12.9
                                          )
      vehicle = FactoryBot.create(:vehicle, transport_modality: trans_mod, status: :available)
  
      login_as user, scope: :user 
      visit service_order_path(service_order.id)

      within 'select' do 
        expect(page).not_to have_content 'Ghetto'
      end
    end
  end
  
end