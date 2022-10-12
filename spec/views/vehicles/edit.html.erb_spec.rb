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
      trans_mod = FactoryBot.create(:transport_modality, name: 'Engenheiros do Hawai')
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
      expect(page).to have_select 'Modalidade de transporte', selected: 'Engenheiros do Hawai'
    end

    it 'with success' do 
      trans_mod = FactoryBot.create(:transport_modality, name: 'Kunka Belunga')
      other_trans_mod = FactoryBot.create(:transport_modality, name: 'Busão do João')
      vehicle = Vehicle.create!(
                                license_plate: 'ABC1D23',
                                brand_name: 'Fiat',
                                vehicle_type: 'Van',
                                fabrication_year: '2010',
                                maximum_capacity: '500',
                                transport_modality: trans_mod
                            )  

      login_as admin, scope: :user 
      visit edit_vehicle_path(vehicle.id)

      fill_in 'Placa do veículo', with: 'AZN5P58'
      fill_in 'Marca', with: 'Chevrolet'
      fill_in 'Modelo', with: 'Carreta'
      fill_in 'Ano de fabricação', with: '2005'
      fill_in 'Capacidade máxima (De Peso)', with: '700'
      select 'Busão do João', from: 'Modalidade de transporte'
      click_on 'Enviar'

      expect(current_path).to eq vehicle_path(vehicle.id)
      expect(page).to have_content 'Veículo atualizado com sucesso'
      expect(page).to have_content 'Carreta Chevrolet'
      expect(page).to have_content 'Placa do veículo: AZN5P58'
      expect(page).to have_content 'Ano de fabricação: 2005'
      expect(page).to have_content 'Capacidade máxima (De Peso): 700Kgs'
      expect(page).to have_content 'Modalidade de transporte: Busão do João'
    end

    it 'and dont fill all fields' do 
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
      visit edit_vehicle_path(vehicle.id)

      fill_in 'Placa do veículo', with: ''
      fill_in 'Marca', with: ''
      fill_in 'Modelo', with: ''
      fill_in 'Ano de fabricação', with: ''
      click_on 'Enviar'

      expect(page).to have_content 'Veículo não atualizado'
      expect(page).to have_content 'Verifique os erros abaixo:'
      expect(page).to have_content 'Placa do veículo não pode ficar em branco'
      expect(page).to have_content 'Marca não pode ficar em branco'
      expect(page).to have_content 'Modelo não pode ficar em branco'
      expect(page).to have_content 'Ano de fabricação não pode ficar em branco'
    end

  end
end