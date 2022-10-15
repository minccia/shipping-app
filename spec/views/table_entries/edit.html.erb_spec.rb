require 'rails_helper'

describe 'table_entries/edit.html.erb' do 
  context 'Admin user edit entries from transport modality price tables' do 
    it 'if authenticated' do 
      common_user = FactoryBot.create(:user, role: :common)
      trans_mod = FactoryBot.create(:transport_modality)

      TableEntry.create!(
                         first_interval: 0, second_interval: 1,
                         value: 0.5, weight_price_table_id: trans_mod.weight_price_table.id
                        )
      TableEntry.create!(
                         first_interval: 200, second_interval: 1000,
                         value: 20.3, distance_price_table_id: trans_mod.distance_price_table.id
                        )                
      TableEntry.create!(
                         first_interval: 0, second_interval: 50,
                         value: 48, freight_table_id: trans_mod.freight_table.id
                        )             

      login_as common_user, scope: :user 
      visit transport_modality_path(trans_mod.id)

      within '#weight_price_table' do 
        expect(page).not_to have_button 'Editar'
      end
      within '#distance_price_table' do 
        expect(page).not_to have_button 'Editar'
      end
      within '#freight_table' do 
        expect(page).not_to have_button 'Editar'
      end
    end

    it 'and see a formulary to edit entry from weight price table' do 
      admin = FactoryBot.create(:user, role: :admin)
      trans_mod = FactoryBot.create(:transport_modality)
      TableEntry.create!(
                         first_interval: 0, second_interval: 1,
                         value: 0.5, weight_price_table_id: trans_mod.weight_price_table.id
                        )
  
      login_as admin, scope: :user
      visit transport_modality_path(trans_mod.id)
      within '#weight_price_table' do 
        click_on 'Editar'
      end

      expect(page).to have_field 'De', with: '0'
      expect(page).to have_field 'Até', with: '1'
      expect(page).to have_field 'Valor', with: '0.5'
    end

    it 'and edit entry from weight price table with sucess' do 
      admin = FactoryBot.create(:user, role: :admin)
      trans_mod = FactoryBot.create(:transport_modality)
      TableEntry.create!(
                         first_interval: 0, second_interval: 1,
                         value: 0.5, weight_price_table_id: trans_mod.weight_price_table.id
                        )
  
      login_as admin, scope: :user
      visit transport_modality_path(trans_mod.id)
      within '#weight_price_table' do 
        click_on 'Editar'
      end

      fill_in 'De', with: '10'
      fill_in 'Até', with: '35'
      fill_in 'Valor', with: '39.9'
      click_on 'Adicionar'

      expect(current_path).to eq transport_modality_path(trans_mod.id)
      expect(page).to have_content 'Entrada atualizada com sucesso'
      within '#weight_price_table' do 
        expect(page).to have_content 'De 10Kgs à 35Kgs: R$ 39,90'
      end
    end

    it 'and see a formulary to edit entry from distance price table' do 
      admin = FactoryBot.create(:user, role: :admin)
      trans_mod = FactoryBot.create(:transport_modality)
      TableEntry.create!(
                         first_interval: 100, second_interval: 500,
                         value: 30.0, distance_price_table_id: trans_mod.distance_price_table.id
                        )
  
      login_as admin, scope: :user
      visit transport_modality_path(trans_mod.id)
      within '#distance_price_table' do 
        click_on 'Editar'
      end

      expect(page).to have_field 'De', with: '100'
      expect(page).to have_field 'Até', with: '500'
      expect(page).to have_field 'Valor', with: '30.0'
    end

    it 'and edit entry from distance price table with sucess' do 
      admin = FactoryBot.create(:user, role: :admin)
      trans_mod = FactoryBot.create(:transport_modality)
      TableEntry.create!(
                         first_interval: 0, second_interval: 1,
                         value: 0.5, distance_price_table_id: trans_mod.distance_price_table.id
                        )
  
      login_as admin, scope: :user
      visit transport_modality_path(trans_mod.id)
      within '#distance_price_table' do 
        click_on 'Editar'
      end

      fill_in 'De', with: '20'
      fill_in 'Até', with: '40'
      fill_in 'Valor', with: '50.9'
      click_on 'Adicionar'

      expect(current_path).to eq transport_modality_path(trans_mod.id)
      expect(page).to have_content 'Entrada atualizada com sucesso'
      within '#distance_price_table' do 
        expect(page).to have_content 'De 20Km à 40Km: R$ 50,90'
      end
    end

    it 'and see a formulary to edit entry from freight table' do 
      admin = FactoryBot.create(:user, role: :admin)
      trans_mod = FactoryBot.create(:transport_modality)
      TableEntry.create!(
                         first_interval: 0, second_interval: 50,
                         value: 48, freight_table_id: trans_mod.freight_table.id
                        )
  
      login_as admin, scope: :user
      visit transport_modality_path(trans_mod.id)
      within '#freight_table' do 
        click_on 'Editar'
      end

      expect(page).to have_field 'De', with: '0'
      expect(page).to have_field 'Até', with: '50'
      expect(page).to have_field 'Valor', with: '48.0'
    end

    it 'and edit entry from freight table with sucess' do 
      admin = FactoryBot.create(:user, role: :admin)
      trans_mod = FactoryBot.create(:transport_modality)
      TableEntry.create!(
                         first_interval: 0, second_interval: 50,
                         value: 24, freight_table_id: trans_mod.freight_table.id
                        )
  
      login_as admin, scope: :user
      visit transport_modality_path(trans_mod.id)
      within '#freight_table' do 
        click_on 'Editar'
      end

      fill_in 'De', with: '50'
      fill_in 'Até', with: '100'
      fill_in 'Valor', with: '96'
      click_on 'Adicionar'

      expect(current_path).to eq transport_modality_path(trans_mod.id)
      expect(page).to have_content 'Entrada atualizada com sucesso'
      within '#freight_table' do 
        expect(page).to have_content 'De 50Km à 100Km: 96 Horas (4 Dias)'
      end
    end

    it 'and don fill all fields' do 
      admin = FactoryBot.create(:user, role: :admin)
      trans_mod = FactoryBot.create(:transport_modality)
      tbentry = TableEntry.create!(
                                  first_interval: 0, second_interval: 1,
                                  value: 0.5, distance_price_table_id: trans_mod.distance_price_table.id
                             )
  
      login_as admin, scope: :user
      visit transport_modality_path(trans_mod.id)
      within '#distance_price_table' do 
        click_on 'Editar'
      end

      fill_in 'De', with: ''
      fill_in 'Até', with: ''
      fill_in 'Valor', with: ''
      click_on 'Adicionar'

      expect(current_path).to eq table_entry_path(tbentry.id)
      expect(page).to have_content 'Entrada não atualizada'
    end
  end

end