require 'rails_helper'

describe 'table_entries/new.html.erb' do 
  let(:admin) { FactoryBot.create(:user, role: :admin) }

  context 'Admin user add entries to transport modality price tables' do 
    it 'if authenticated as an admin' do 
      common_user = FactoryBot.create(:user)
      trans_mod = FactoryBot.create(:transport_modality)

      login_as common_user, scope: :user
      visit transport_modality_path(trans_mod.id)

      expect(page).not_to have_field 'De'
      expect(page).not_to have_field 'Até'
      expect(page).not_to have_field 'Preço'
      expect(page).not_to have_button 'Adicionar'
    end

    it 'from details page' do 
      trans_mod = FactoryBot.create(:transport_modality)

      login_as admin, scope: :user
      visit transport_modality_path(trans_mod.id)

      expect(page).to have_content 'Tabela de preços por Peso'
      expect(page).to have_content 'Tabela de preços por Distância'
      expect(page).to have_field 'De'
      expect(page).to have_field 'Até'
      expect(page).to have_field 'Preço'
      expect(page).to have_button 'Adicionar'
    end

    it 'with success' do 
      trans_mod = FactoryBot.create(:transport_modality)

      login_as admin, scope: :user
      visit transport_modality_path(trans_mod.id)

      within '#weight_price_table' do 
        fill_in 'De', with: '5'
        fill_in 'Até', with: '10'
        fill_in 'Preço', with: '1.0'
        click_on 'Adicionar'
      end

      within '#distance_price_table' do 
        fill_in 'De', with: '0'
        fill_in 'Até', with: '20'
        fill_in 'Preço', with: '5'
        click_on 'Adicionar'
      end

      expect(page).to have_content 'Preço adicionado a tabela com sucesso'      
      expect(page).to have_content 'De 5Kgs à 10Kgs: R$ 1,00'
      expect(page).to have_content 'De 0Km à 20Km: R$ 5,00'
    end

    it 'and dont fill all fields' do 
      trans_mod = FactoryBot.create(:transport_modality)

      login_as admin, scope: :user
      visit transport_modality_path(trans_mod.id)

      within '#weight_price_table' do 
        fill_in 'De', with: ''
        fill_in 'Até', with: ''
        fill_in 'Preço', with: ''
        click_on 'Adicionar'
      end

      expect(page).to have_content 'Preço não foi adicionado'
    end

  end
end