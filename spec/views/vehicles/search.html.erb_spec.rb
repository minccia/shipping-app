require 'rails_helper'

describe 'vehicles/search.html.erb' do 
  let(:user) { FactoryBot.create(:user) }

  context 'User search vehicles' do 
    it 'finding one vehicle' do 
      vehicle = FactoryBot.create(:vehicle, license_plate: 'ABC1D23')

      login_as user, scope: :user
      visit vehicles_path
      fill_in 'Buscar Veículo', with: 'ABC1D23'
      click_on 'Buscar'

      expect(current_path).to eq search_vehicles_path
      expect(page).to have_content 'Resultados da busca por: ABC1D23'
      expect(page).to have_content '1 Veículo encontrado'
      expect(page).to have_content 'Placa do veículo: ABC1D23'
      expect(page).to have_content "Modalidade de transporte: #{vehicle.transport_modality.name}"
      expect(page).to have_content 'Status: Disponível'
    end

    it 'finding many vehicles' do 
      first_vehicle = FactoryBot.create(:vehicle, license_plate: 'ABC1D23')
      second_vehicle = FactoryBot.create(:vehicle, license_plate: 'ABC7Z99', status: :on_maintenance)
      third_vehicle = FactoryBot.create(:vehicle, license_plate: 'ZIMBABUÉ', status: :in_operation)

      login_as user, scope: :user
      visit vehicles_path
      fill_in 'Buscar Veículo', with: 'ABC'
      click_on 'Buscar'

      expect(current_path).to eq search_vehicles_path
      expect(page).to have_content 'Resultados da busca por: ABC'
      expect(page).to have_content '2 Veículos encontrados'
      expect(page).to have_content 'Placa do veículo: ABC1D23'
      expect(page).to have_content "Modalidade de transporte: #{first_vehicle.transport_modality.name}"
      expect(page).to have_content 'Status: Disponível'
      expect(page).to have_content 'Placa do veículo: ABC7Z99'
      expect(page).to have_content "Modalidade de transporte: #{second_vehicle.transport_modality.name}"
      expect(page).to have_content 'Status: Em manutenção'
      expect(page).not_to have_content 'Placa do veículo: ZIMBABUÉ'
      expect(page).not_to have_content "Modalidade de transporte: #{third_vehicle.transport_modality.name}"
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