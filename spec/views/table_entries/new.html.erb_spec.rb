require 'rails_helper'

describe 'table_entries/new.html.erb' do 
  let(:admin) { FactoryBot.create(:user, role: :admin) }

  context 'Admin user add entries to transport modality tables' do 
    it 'if authenticated as an admin' do 
      common_user = FactoryBot.create(:user)
      trans_mod = FactoryBot.create(:transport_modality)

      login_as common_user, scope: :user
      visit transport_modality_path(trans_mod.id)

      within '#weight_price_table' do 
        expect(page).not_to have_field 'De'
        expect(page).not_to have_field 'Até'
        expect(page).not_to have_field 'Valor'
        expect(page).not_to have_button 'Adicionar'
      end

      within '#distance_price_table' do 
        expect(page).not_to have_field 'De'
        expect(page).not_to have_field 'Até'
        expect(page).not_to have_field 'Valor'
        expect(page).not_to have_button 'Adicionar'
      end

      within '#freight_table' do 
        expect(page).not_to have_field 'De'
        expect(page).not_to have_field 'Até'
        expect(page).not_to have_field 'Valor'
        expect(page).not_to have_button 'Adicionar'
      end
    end

    it 'from details page' do 
      trans_mod = FactoryBot.create(:transport_modality)

      login_as admin, scope: :user
      visit transport_modality_path(trans_mod.id)

      expect(page).to have_content 'Tabela de preços por Peso'
      expect(page).to have_content 'Tabela de preços por Distância'
      expect(page).to have_content 'Tabela de prazos'

      within '#weight_price_table' do 
        expect(page).to have_field 'De'
        expect(page).to have_field 'Até'
        expect(page).to have_field 'Valor'
        expect(page).to have_button 'Adicionar'
      end

      within '#distance_price_table' do 
        expect(page).to have_field 'De'
        expect(page).to have_field 'Até'
        expect(page).to have_field 'Valor'
        expect(page).to have_button 'Adicionar'
      end

      within '#freight_table' do 
        expect(page).to have_field 'De'
        expect(page).to have_field 'Até'
        expect(page).to have_field 'Valor'
        expect(page).to have_button 'Adicionar'
      end
    end

    it 'with success' do 
      trans_mod = FactoryBot.create(:transport_modality)

      login_as admin, scope: :user
      visit transport_modality_path(trans_mod.id)

      within '#weight_price_table' do 
        fill_in 'De', with: '5'
        fill_in 'Até', with: '10'
        fill_in 'Valor', with: '1.0'
        click_on 'Adicionar'
      end

      within '#distance_price_table' do 
        fill_in 'De', with: '0'
        fill_in 'Até', with: '20'
        fill_in 'Valor', with: '5'
        click_on 'Adicionar'
      end

      within '#freight_table' do 
        fill_in 'De', with: '0'
        fill_in 'Até', with: '50'
        fill_in 'Valor', with: '24'
        click_on 'Adicionar'
      end

      expect(page).to have_content 'Entrada adicionada na tabela com sucesso'      
      expect(page).to have_content 'De 5Kgs à 10Kgs: R$ 1,00'
      expect(page).to have_content 'De 0Km à 20Km: R$ 5,00'
      expect(page).to have_content 'De 0Km à 50Km: 24 Horas (1 Dia)'
    end

    it 'and dont fill all fields' do 
      trans_mod = FactoryBot.create(:transport_modality)

      login_as admin, scope: :user
      visit transport_modality_path(trans_mod.id)

      within '#weight_price_table' do 
        fill_in 'De', with: ''
        fill_in 'Até', with: ''
        fill_in 'Valor', with: ''
        click_on 'Adicionar'
      end

      expect(page).to have_content 'Entrada não foi adicionada'
    end

    it 'and there is already a table entry with the same range' do 
      trans_mod = FactoryBot.create(:transport_modality)
      FactoryBot.create(:table_entry, first_interval: 10,
                        second_interval: 20, weight_price_table: trans_mod.weight_price_table)
      
      login_as admin, scope: :user
      visit transport_modality_path(trans_mod.id)

      within '#weight_price_table' do 
        fill_in 'De', with: '10'
        fill_in 'Até', with: '30'
        fill_in 'Valor', with: '3.9'
        click_on 'Adicionar'
      end

      expect(trans_mod.weight_price_table.table_entries.length).to eq 1
      expect(page).to have_content 'Entrada não foi adicionada'
    end

  end
end