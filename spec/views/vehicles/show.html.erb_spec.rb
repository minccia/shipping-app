require 'rails_helper'

describe 'vehicles/show.html.erb' do 
  let(:user) { FactoryBot.create(:user, role: :common) }

  context 'User view vehicle details' do 
    it 'through the details page' do 
      vehicle = FactoryBot.create(:vehicle, license_plate: 'ABC1D23')

      login_as user, scope: :user
      visit vehicles_path 
      fill_in 'Buscar Veículo', with: 'ABC1D23'
      click_on 'Buscar'
      click_on 'ABC1D23'

      expect(current_path).to eq vehicle_path(vehicle.id)
    end

    it 'with success' do 
      transport_modality = FactoryBot.create(:transport_modality, name: 'Busão do João')

      vehicle = Vehicle.create!(
                                license_plate: 'ABC1D23',
                                brand_name: 'Fiat',
                                vehicle_type: 'Carreta',
                                fabrication_year: '2005',
                                maximum_capacity: 700,
                                status: :available,
                                transport_modality: transport_modality
                            )

      login_as user, scope: :user 
      visit vehicle_path(vehicle.id)

      expect(page).to have_content 'Carreta Fiat'
      expect(page).to have_content 'Placa do veículo: ABC1D23'
      expect(page).to have_content 'Ano de fabricação: 2005'
      expect(page).to have_content 'Capacidade máxima (De Peso): 700Kgs'
      expect(page).to have_content 'Status: Disponível'
      expect(page).to have_content 'Modalidade de transporte: Busão do João'
    end
  end

  context 'Admin user send a vehicle to maintenance' do 
    it 'if authenticated' do 
      vehicle = FactoryBot.create(:vehicle)

      login_as user, scope: :user 
      visit vehicle_path(vehicle.id)
      expect(page).not_to have_link 'Enviar para manutenção'

      visit send_to_maintenance_vehicle_path(vehicle.id)

      expect(page).to have_content 'Você não possui acesso a esta página pois não é um admin'
    end

    it 'through details page' do 
      admin_user = FactoryBot.create(:user, role: :admin)
      vehicle = FactoryBot.create(:vehicle, license_plate: 'ABC1D23')

      login_as admin_user, scope: :user 
      visit vehicle_path(vehicle.id)
      click_on 'Enviar para manutenção'

      expect(current_path).to eq vehicles_path 
      expect(page).to have_content 'Veículo ABC1D23 enviado para manutenção com sucesso'
    end

    it 'expect if vehicle is already in maintenance' do 
      admin_user = FactoryBot.create(:user, role: :admin)
      vehicle = FactoryBot.create(:vehicle, license_plate: 'ABC1D23', status: :on_maintenance)

      login_as admin_user, scope: :user 
      visit vehicle_path(vehicle.id)
      expect(page).not_to have_link 'Enviar para manutenção'

      visit send_to_maintenance_vehicle_path(vehicle.id)

      expect(page).to have_content 'Veículo ABC1D23 já está em manutenção'
    end
  end
end