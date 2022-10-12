require 'rails_helper'

describe 'vehicles/search.html.erb' do 
  let(:user) { FactoryBot.create(:user) }

  context 'User search vehicles' do 
    it 'finding one vehicle through the license plate' do 
      vehicle = FactoryBot.create(:vehicle, license_plate: 'ABC1D23',
                                  brand_name: 'Fiat', vehicle_type: 'Carreta')

      login_as user, scope: :user
      visit vehicles_path
      fill_in 'Buscar Veículo', with: 'ABC1D23'
      click_on 'Buscar'

      expect(current_path).to eq search_vehicles_path
      expect(page).to have_content 'Resultados da busca por: ABC1D23'
      expect(page).to have_content '1 Veículo encontrado'
      expect(page).to have_content 'Carreta Fiat'
      expect(page).to have_content 'Placa do veículo: ABC1D23'
      expect(page).to have_content "Modalidade de transporte: #{vehicle.transport_modality.name}"
      expect(page).to have_content 'Status: Disponível'
    end

    it 'finding many vehicles through the license plate' do 
      first_vehicle = FactoryBot.create(:vehicle, license_plate: 'ABC1D23',
                                        brand_name: 'Chevrolet', vehicle_type: 'Motinha')

      second_vehicle = FactoryBot.create(:vehicle, license_plate: 'ABC7Z99', status: :on_maintenance,
                                         brand_name: 'Lamborghini', vehicle_type: 'Fusca')
      third_vehicle = FactoryBot.create(:vehicle, license_plate: 'ZIMBABUÉ', status: :in_operation)

      login_as user, scope: :user
      visit vehicles_path
      fill_in 'Buscar Veículo', with: 'ABC'
      click_on 'Buscar'

      expect(current_path).to eq search_vehicles_path
      expect(page).to have_content 'Resultados da busca por: ABC'
      expect(page).to have_content '2 Veículos encontrados'
      expect(page).to have_content 'Motinha Chevrolet'
      expect(page).to have_content 'Placa do veículo: ABC1D23'
      expect(page).to have_content "Modalidade de transporte: #{first_vehicle.transport_modality.name}"
      expect(page).to have_content 'Status: Disponível'
      expect(page).to have_content 'Fusca Lamborghini'
      expect(page).to have_content 'Placa do veículo: ABC7Z99'
      expect(page).to have_content "Modalidade de transporte: #{second_vehicle.transport_modality.name}"
      expect(page).to have_content 'Status: Em manutenção'
      expect(page).not_to have_content 'Placa do veículo: ZIMBABUÉ'
      expect(page).not_to have_content "Modalidade de transporte: #{third_vehicle.transport_modality.name}"
      expect(page).not_to have_content 'Status: Em operação'
    end

    it 'finding one vehicle through the transport modality name' do 
      trans_mod = FactoryBot.create(:transport_modality, name: 'Expresso')
      vehicle = FactoryBot.create(:vehicle, transport_modality: trans_mod,
                                  brand_name: 'Fiat', vehicle_type: 'Carreta')

      login_as user, scope: :user
      visit vehicles_path
      fill_in 'Buscar Veículo', with: 'Expresso'
      click_on 'Buscar'

      expect(current_path).to eq search_vehicles_path
      expect(page).to have_content 'Resultados da busca por: Expresso'
      expect(page).to have_content '1 Veículo encontrado'
      expect(page).to have_content 'Carreta Fiat'
      expect(page).to have_content "Placa do veículo: #{vehicle.license_plate}"
      expect(page).to have_content "Modalidade de transporte: Expresso"
      expect(page).to have_content 'Status: Disponível'
    end

    it 'finding many vehicles through the transport modality name' do 
      first_trans_mod = FactoryBot.create(:transport_modality, name: 'Expresso')
      second_trans_mod = FactoryBot.create(:transport_modality, name: 'Busão do João')

      first_vehicle = FactoryBot.create(:vehicle, transport_modality: first_trans_mod,
                                        brand_name: 'Chevrolet', vehicle_type: 'Motinha')

      second_vehicle = FactoryBot.create(:vehicle, transport_modality: first_trans_mod,
                                         brand_name: 'Fiat', vehicle_type: 'Uno',
                                         status: :on_maintenance)

      third_vehicle = FactoryBot.create(:vehicle, transport_modality: second_trans_mod, 
                                        status: :in_operation)

      login_as user, scope: :user
      visit vehicles_path
      fill_in 'Buscar Veículo', with: 'Expresso'
      click_on 'Buscar'

      expect(current_path).to eq search_vehicles_path
      expect(page).to have_content 'Resultados da busca por: Expresso'
      expect(page).to have_content '2 Veículos encontrados'
      expect(page).to have_content 'Motinha Chevrolet'
      expect(page).to have_content "Placa do veículo: #{first_vehicle.license_plate}"
      expect(page).to have_content "Modalidade de transporte: Expresso"
      expect(page).to have_content 'Status: Disponível'
      expect(page).to have_content 'Uno Fiat'
      expect(page).to have_content "Placa do veículo: #{second_vehicle.license_plate}"
      expect(page).to have_content "Modalidade de transporte: Expresso"
      expect(page).to have_content 'Status: Em manutenção'
      expect(page).not_to have_content "Placa do veículo: #{third_vehicle.license_plate}"
      expect(page).not_to have_content "Modalidade de transporte: Busão do João"
      expect(page).not_to have_content 'Status: Em operação'
    end

    it 'and dont find any vehicles' do 
      first_vehicle = FactoryBot.create(:vehicle, license_plate: 'ABC1D23')

      login_as user, scope: :user
      visit vehicles_path
      fill_in 'Buscar Veículo', with: 'MALAKOI'
      click_on 'Buscar'

      expect(current_path).to eq vehicles_path
      expect(page).to have_content 'Nenhum Veículo encontrado'
    end
  end
end