require 'rails_helper'

describe 'transport_modalities/show.html.erb' do 
  let(:admin) { FactoryBot.create(:user, role: 'admin') }

  context 'User view transport modality details' do 
    it 'if authenticated' do 
      trans_mod = FactoryBot.create(:transport_modality)

      visit transport_modality_path(trans_mod.id)
      expect(current_path).to eq root_path 
      expect(page).to have_content 'Você não possui acesso a esta página pois não é um admin'
    end

    it 'with success' do 
      TransportModality.create!(
                              name: 'Ghetto Expresso',
                              minimum_distance: 10,
                              maximum_distance: 100,
                              minimum_weight: 100,
                              maximum_weight: 10000,
                              fee: 19.5
                          )

      login_as admin, scope: :user 
      visit transport_modalities_path 
      click_on 'Ghetto Expresso'

      expect(page).to have_content 'Ghetto Expresso'
      expect(page).to have_content 'Distância mínima praticada: 10Km'
      expect(page).to have_content 'Distância máxima praticada: 100Km'
      expect(page).to have_content 'Peso mínimo da carga: 100Kg'
      expect(page).to have_content 'Peso máximo da carga: 10000Kg'
      expect(page).to have_content 'Taxa fixa: R$ 19,50'
      expect(page).to have_content 'Ativa: Sim'
    end

    it 'and it doenst have minimum requirements' do 
      TransportModality.create!(
                              name: 'Ghetto Expresso',
                              maximum_distance: 100,
                              maximum_weight: 10000,
                              fee: 19.5
                          )

      login_as admin, scope: :user 
      visit transport_modalities_path 
      click_on 'Ghetto Expresso'

      expect(page).to have_content 'Ghetto Expresso'
      expect(page).to have_content 'Distância mínima praticada: Não possui um valor mínimo'
      expect(page).to have_content 'Distância máxima praticada: 100Km'
      expect(page).to have_content 'Peso mínimo da carga: Não possui um valor mínimo'
      expect(page).to have_content 'Peso máximo da carga: 10000Kg'
      expect(page).to have_content 'Taxa fixa: R$ 19,50'
      expect(page).to have_content 'Ativa: Sim'
    end
  end

end