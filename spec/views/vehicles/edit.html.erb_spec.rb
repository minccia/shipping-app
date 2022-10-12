require 'rails_helper'

describe 'vehicles/edit.html.erb' do 
  let(:admin) { FactoryBot.create(:user, role: :admin) }
  
  context 'Admin user edit a vehicle' do 
    it 'if authenticated' do 
      vehicle = FactoryBot.create(:vehicle)
      common_user = FactoryBot.create(:user, role: :common)

      login_as common_user, scope: :user 
      visit vehicle_path(vehicle.id)
      
      expect(page).not_to have_content 'Editar'

      visit edit_vehicle_path(vehicle.id)

      expect(page).to have_content 'Você não possui acesso a esta página pois não é um admin'
    end

    it 'from a formulary' do 
      trans_mod = FactoryBot.create(:transport_modality)
      vehicle = Vehicle.create!(
                                license_plate: 'ABC1D23',
                                brand_name: 'Fiat',
                                vehicle_type: 'Van',
                                fabrication_year: '2010',
                                maximum_capacity: '500',
                                transport_modality: trans_mod
                            )

      login_as admin, scope: :user 
      visit vehicle_path(vehicle.id)
      click_on 'Editar'

      expect(current_path).to eq edit_vehicle_path(vehicle.id)
      expect(page).to have_field 'Placa do veículo', with: 'ABC1D23'
      expect(page).to have_field 'Marca', with: 'Fiat'
      expect(page).to have_field 'Modelo', with: 'Van'
      expect(page).to have_field 'Ano de fabricação', with: '2010'
      expect(page).to have_field 'Capacidade máxima (De Peso)', with: '500'
    end
  end
end