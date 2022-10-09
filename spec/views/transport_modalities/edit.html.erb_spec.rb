require 'rails_helper'

describe 'transport_modalities/edit.html.erb' do 
  let(:admin) { FactoryBot.create(:user, role: 'admin') }

  context 'Admin user edit existing transport modality' do 
    it 'if authenticated' do 
      trans_mod = FactoryBot.create(:transport_modality)

      visit edit_transport_modality_path(trans_mod.id)

      expect(page).to have_content 'Você não possui acesso a esta página pois não é um admin'
    end

    it 'from a formulary' do 
      trans_mod = TransportModality.create!(
                              name: 'Ghetto Expresso',
                              minimum_distance: 10,
                              maximum_distance: 100,
                              minimum_weight: 100,
                              maximum_weight: 10000,
                              fee: 19.5
                          )

      login_as admin, scope: :user
      visit transport_modality_path(trans_mod.id)
      click_on 'Editar'

      expect(page).to have_content 'Editar Modalidade de transporte'
      expect(page).to have_field 'Nome da modalidade', with: 'Ghetto Expresso'
      expect(page).to have_field 'Distância mínima praticada', with: '10'
      expect(page).to have_field 'Distância máxima praticada', with: '100'
      expect(page).to have_field 'Peso mínimo da carga', with: '100'
      expect(page).to have_field 'Peso máximo da carga', with: '10000'
      expect(page).to have_field 'Taxa fixa', with: '19.5'
      expect(page).to have_checked_field 'Ativa'
    end

    it 'from a formulary' do 
      trans_mod = FactoryBot.create(:transport_modality)

      login_as admin, scope: :user
      visit edit_transport_modality_path(trans_mod.id)

      fill_in 'Nome da modalidade', with: 'Lambada Kraviz'
      fill_in 'Distância mínima praticada', with: ''
      fill_in 'Distância máxima praticada', with: '1000'
      fill_in 'Peso mínimo da carga', with: ''
      fill_in 'Peso máximo da carga', with: '5000'
      fill_in 'Taxa fixa', with: '20.5'
      uncheck 'Ativa'
      click_on 'Enviar'

      expect(current_path).to eq transport_modalities_path 
      expect(page).to have_content 'Modalidade atualizada com sucesso'
      expect(page).to have_content 'Lambada Kraviz'
      expect(page).to have_content 'Não possui um valor mínimo em Km'
      expect(page).to have_content '1000 Km'
      expect(page).to have_content 'R$ 20,50'
      expect(page).to have_content 'Não'
    end

    it 'and dont fill mandatory fields' do 
      trans_mod = FactoryBot.create(:transport_modality)
  
      login_as admin, scope: :user
      visit edit_transport_modality_path(trans_mod.id)
  
      fill_in 'Nome da modalidade', with: ''
      fill_in 'Distância máxima praticada', with: ''
      fill_in 'Peso máximo da carga', with: ''
      click_on 'Enviar'
  
      expect(page).to have_content 'Modalidade não atualizada'
      expect(page).to have_content 'Verifique os erros abaixo:'
      expect(page).to have_content 'Nome da modalidade não pode ficar em branco'
      expect(page).to have_content 'Distância máxima praticada não pode ficar em branco'
      expect(page).to have_content 'Peso máximo da carga não pode ficar em branco'
    end
  end

end