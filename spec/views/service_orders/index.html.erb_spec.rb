require 'rails_helper'

describe 'service_orders/index.html.erb' do 
  let(:user) { FactoryBot.create(:user) }

  context 'Common user view pending service orders' do 
    it 'if authenticated' do 
      visit service_orders_path 
  
      expect(current_path).to eq new_user_session_path
    end

    it 'with success' do 
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

      ServiceOrder.create(
                          sender_full_address: 'Rua Vera Cruz, 412',
                          sender_zip_code: '60123120',
                          package_height: 20, package_width: 20,
                          package_depth: 20, package_weight: 200,
                          receiver_name: 'Sérgio Paulino',
                          receiver_full_address: 'Av Das Laranjeiras, 500',
                          receiver_zip_code: '60334520',
                          distance: 500,
                          status: 'finished'
                        )

      login_as user, scope: :user
      visit root_path 

      within 'nav' do
        click_on 'Ordens de serviço'
      end

      expect(page).to have_content 'Ordem de serviço <ABCDE12345678>'
      expect(page).to have_content 'Endereço do remetente: Av Das Palmas, 100'
      expect(page).to have_content 'Nome do destinatário: Paola Dobrotto'
      expect(page).to have_content 'Endereço do destinatário: Av Das Laranjeiras, 500'
      expect(page).to have_content 'Distância: 100 metros'
      expect(page).to have_content 'Status: Pendente'
      expect(page).not_to have_content 'Endereço do remetente: Rua Vera Cruz, 412'
      expect(page).not_to have_content 'Nome do destinatário: Sérgio Paulino'
      expect(page).not_to have_content 'Distância: 500 metros'
    end

    it 'unless there arent any service orders' do 
      login_as user, scope: :user
      visit service_orders_path 

      expect(page).to have_content 'Não há ordens de serviço ainda'
    end

    it 'and return to home page' do 
      login_as user, scope: :user
      visit service_orders_path
      click_on 'Início'

      expect(current_path).to eq root_path
    end
  end

  context 'Common user view service orders in progress' do 
    it 'with success' do 
      allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('ABCDE12345678')
      ServiceOrder.create(
                          sender_full_address: 'Av Das Palmas, 100',
                          sender_zip_code: '60334120',
                          package_height: 10, package_width: 10,
                          package_depth: 10, package_weight: 100,
                          receiver_name: 'Paola Dobrotto',
                          receiver_full_address: 'Av Das Laranjeiras, 500',
                          receiver_zip_code: '60334520',
                          distance: 100,
                          status: :in_progress
                        )
      ServiceOrder.create(
                          sender_full_address: 'Rua Vera Cruz, 412',
                          sender_zip_code: '60123120',
                          package_height: 20, package_width: 20,
                          package_depth: 20, package_weight: 200,
                          receiver_name: 'Sérgio Paulino',
                          receiver_full_address: 'Av Das Laranjeiras, 500',
                          receiver_zip_code: '60334520',
                          distance: 500,
                          status: :pending
                        )

      login_as user, scope: :user
      visit root_path
      click_on 'Ordens de serviço'
      click_on 'Ordens em andamento'

      expect(page).to have_content 'Ordem de serviço <ABCDE12345678>'
      expect(page).to have_content 'Endereço do remetente: Av Das Palmas, 100'
      expect(page).to have_content 'Nome do destinatário: Paola Dobrotto'
      expect(page).to have_content 'Endereço do destinatário: Av Das Laranjeiras, 500'
      expect(page).to have_content 'Distância: 100 metros'
      expect(page).to have_content 'Status: Em andamento'
      expect(page).not_to have_content 'Endereço do remetente: Rua Vera Cruz, 412'
      expect(page).not_to have_content 'Nome do destinatário: Sérgio Paulino'
      expect(page).not_to have_content 'Distância: 500 metros'
      expect(page).not_to have_content 'Status: Pendente'
    end

    it 'and finishes it' do 
      service_order = FactoryBot.create(:service_order, status: :in_progress, distance: 80, package_weight: 20)
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

      login_as user, scope: :user 
      visit service_order_path(service_order.id)
      click_on 'Encerrar ordem de serviço'

      expect(page).to have_content 'Ordem de serviço encerrada com sucesso'
      expect(page).to have_content 'Ordem de serviço encerrada'
      expect(page).to have_content "Data de encerramento: #{ Date.today.strftime("%d/%m/%Y") }"
    end
  end
  
end