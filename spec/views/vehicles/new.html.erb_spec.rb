require 'rails_helper'

describe 'vehicles/new.html.erb' do 
  let(:admin) { FactoryBot.create(:user, role: 'admin') }

  context 'Admin user register new vehicle to a transport modality' do 
    it 'if authenticated' do 
      visit vehicles_path 

      expect(page).not_to have_content 'Novo Veículo'

      visit new_vehicle_path

      expect(page).to have_content 'Você não possui acesso a esta página pois não é um admin'
    end

    it 'from a formulary' do 
      login_as admin, scope: :user
      visit vehicles_path 
      click_on 'Novo Veículo'

      expect(current_path).to eq new_vehicle_path
      expect(page).to have_field 'Placa do veículo'
      expect(page).to have_field 'Marca'
      expect(page).to have_field 'Modelo'
      expect(page).to have_field 'Ano de fabricação'
      expect(page).to have_field 'Capacidade máxima (De Peso)'
      expect(page).to have_select 'Modalidade de transporte'
    end

    it 'with success' do
      transport_modality = FactoryBot.create(:transport_modality, name: 'Walt Smedley')

      login_as admin, scope: :user
      visit new_vehicle_path 

      fill_in 'Placa do veículo', with: 'ABC1D23'
      fill_in 'Marca', with: 'Chevrolet'
      fill_in 'Modelo', with: 'Carreta'
      fill_in 'Ano de fabricação', with: '1980'
      fill_in 'Capacidade máxima (De Peso)', with: '500'
      select 'Walt Smedley', from: 'Modalidade de transporte'
      click_on 'Enviar'

      expect(current_path).to eq vehicles_path 
      expect(page).to have_content 'Veículo criado com sucesso'
      expect(transport_modality.vehicles.count).to eq 1
    end

    it 'and dont fill all fields' do 
      login_as admin, scope: :user
      visit new_vehicle_path 

      fill_in 'Placa do veículo', with: ''
      fill_in 'Marca', with: ''
      fill_in 'Modelo', with: ''
      fill_in 'Ano de fabricação', with: ''
      fill_in 'Capacidade máxima (De Peso)', with: ''
      click_on 'Enviar'

      expect(page).to have_content 'Veículo não foi criado'
      expect(page).to have_content 'Verifique os erros abaixo:'
      expect(page).to have_content 'Placa do veículo não pode ficar em branco'
      expect(page).to have_content 'Marca não pode ficar em branco'
      expect(page).to have_content 'Modelo não pode ficar em branco'
      expect(page).to have_content 'Ano de fabricação não pode ficar em branco'
      expect(page).to have_content 'Capacidade máxima (De Peso) não pode ficar em branco'
    end
  end
end