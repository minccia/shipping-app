require 'rails_helper'

describe 'transport_modalities/show.html.erb' do 
  let(:user) { FactoryBot.create(:user) }

  context 'User view transport modality details' do 
  
    it 'if authenticated' do 
      trans_mod = FactoryBot.create(:transport_modality)

      visit transport_modality_path(trans_mod.id)
      expect(current_path).to eq new_user_session_path
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

      login_as user, scope: :user 
      visit transport_modalities_path 
      click_on 'Ghetto Expresso'

      expect(page).to have_content 'Ghetto Expresso'
      expect(page).to have_content 'Distância mínima praticada: 10 Km'
      expect(page).to have_content 'Distância máxima praticada: 100 Km'
      expect(page).to have_content 'Peso mínimo da carga: 100 Kg'
      expect(page).to have_content 'Peso máximo da carga: 10000 Kg'
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

      login_as user, scope: :user 
      visit transport_modalities_path 
      click_on 'Ghetto Expresso'

      expect(page).to have_content 'Ghetto Expresso'
      expect(page).to have_content 'Distância mínima praticada: Não possui um valor mínimo em Km'
      expect(page).to have_content 'Distância máxima praticada: 100 Km'
      expect(page).to have_content 'Peso mínimo da carga: Não possui um valor mínimo em Kg'
      expect(page).to have_content 'Peso máximo da carga: 10000 Kg'
      expect(page).to have_content 'Taxa fixa: R$ 19,50'
      expect(page).to have_content 'Ativa: Sim'
    end
  end

  context 'User view transport modality price tables' do 
    it 'with success' do 
      trans_mod = FactoryBot.create(:transport_modality)
  
      TableEntry.create!(first_interval: 0, second_interval: 1,
                         price: 0.5, weight_price_table_id: trans_mod.weight_price_table.id)
  
      TableEntry.create!(first_interval: 1, second_interval: 2, 
                         price: 1.0, weight_price_table_id: trans_mod.weight_price_table.id)
  
      TableEntry.create!(first_interval: 0, second_interval: 20, 
                         price: 5, distance_price_table_id: trans_mod.distance_price_table.id)
  
      TableEntry.create!(first_interval: 20, second_interval: 40, 
                         price: 10, distance_price_table_id: trans_mod.distance_price_table.id)
  
      login_as user, scope: :user
      visit transport_modality_path(trans_mod.id)
      
      within '#weight_price_table' do 
        expect(page).to have_content 'Tabela de preços por Peso'
        expect(page).to have_content 'De 0Kgs à 1Kgs: R$ 0,50'
        expect(page).to have_content 'De 1Kgs à 2Kgs: R$ 1,00'
      end
  
      within '#distance_price_table' do 
        expect(page).to have_content 'Tabela de preços por Distância'
        expect(page).to have_content 'De 0Km à 20Km: R$ 5,00'
        expect(page).to have_content 'De 20Km à 40Km: R$ 10,00'
      end
    end
  end

end