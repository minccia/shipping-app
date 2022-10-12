require 'rails_helper'

describe 'transport_modality/index.html.erb' do 

  context 'User view transport modalities' do 
    let(:user) { FactoryBot.create(:user) }

    it 'if authenticated' do 
      visit root_path

      expect(page).not_to have_content 'Modalidades de transporte'

      visit transport_modalities_path

      expect(current_path).to eq new_user_session_path
    end

    it 'and there are no modalities' do 
      login_as user, scope: :user 
      visit transport_modalities_path
  
      expect(page).to have_content 'Não há modalidades de transporte ainda'
    end

    it 'and there are not some rows' do 
      FactoryBot.create(:transport_modality, minimum_distance: nil)

      login_as user, scope: :user
      visit transport_modalities_path 
      
      expect(page).to have_content 'Distanc. min.'
      expect(page).to have_content 'Não possui um valor mínimo em Km'
    end

    it 'and dont see a formulary to create new transport modality' do 
      login_as user, scope: :user
      visit transport_modalities_path 

      expect(page).not_to have_content 'Nova Modalidade de transporte'
      expect(page).not_to have_field 'Nome da modalidade'
      expect(page).not_to have_field 'Distância mínima praticada'
      expect(page).not_to have_field 'Distância máxima praticada'
      expect(page).not_to have_field 'Peso mínimo da carga'
      expect(page).not_to have_field 'Peso máximo da carga'
      expect(page).not_to have_field 'Taxa fixa'
      expect(page).not_to have_field 'Ativa'
    end
  end

  context 'Admin user register new transport modality' do 
    let(:admin) { FactoryBot.create(:user, role: :admin) }

    it 'from a formulary' do 
      login_as admin, scope: :user
      visit root_path 
      click_on 'Modalidades de transporte'

      expect(page).to have_field 'Nome da modalidade'
      expect(page).to have_field 'Distância mínima praticada'
      expect(page).to have_field 'Distância máxima praticada'
      expect(page).to have_field 'Peso mínimo da carga'
      expect(page).to have_field 'Peso máximo da carga'
      expect(page).to have_field 'Taxa fixa'
      expect(page).to have_field 'Ativa'
    end

    it 'with success' do 
      login_as admin, scope: :user 
      visit transport_modalities_path 

      fill_in 'Nome da modalidade', with: 'Expresso'
      fill_in 'Distância mínima praticada', with: '1'
      fill_in 'Distância máxima praticada', with: '30'
      fill_in 'Peso mínimo da carga', with: '300'
      fill_in 'Peso máximo da carga', with: '10000'
      fill_in 'Taxa fixa', with: 19.50
      click_on 'Enviar'

      expect(current_path).to eq transport_modalities_path
      expect(page).to have_content 'Expresso'
      expect(page).to have_content '1 Km'
      expect(page).to have_content '30 Km'
      expect(page).to have_content 'R$ 19,50'
      expect(page).to have_content 'Sim'
    end

    it 'and dont fill all mandatory fields' do 
      login_as admin, scope: :user 
      visit transport_modalities_path 

      fill_in 'Nome da modalidade', with: ''
      fill_in 'Taxa fixa', with: ''
      fill_in 'Distância máxima', with: ''
      fill_in 'Peso máximo da carga', with: ''
      click_on 'Enviar'

      expect(page).to have_content 'Modalidade não foi criada'
      expect(page).to have_content 'Verifique os erros abaixo:'
      expect(page).to have_content 'Nome da modalidade não pode ficar em branco'
      expect(page).to have_content 'Taxa fixa não pode ficar em branco'
      expect(page).to have_content 'Distância máxima praticada não pode ficar em branco'
      expect(page).to have_content 'Peso máximo da carga não pode ficar em branco'
    end
  end

end