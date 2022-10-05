require 'rails_helper'

describe 'service_orders/new.html.erb' do 
  let(:admin) { User.create!(name: 'Paola', email: 'paola@email.com', password: '12345678', role: 'admin') }

  context 'Admin user create a new service order' do 
    it 'if authenticated as an admin user' do 
      common_user = User.create!(name: 'Sérgio', email: 'serginho@email.com',
                                 password: '25892928', role: 'common')
      
      login_as common_user, scope: :user
      visit new_service_order_path
      
      expect(page).to have_content 'Você não possui acesso a esta página pois não é um admin'
    end

    it 'from a formulary' do 
      login_as admin, scope: :user
      visit root_path 
      
      within 'nav' do 
        click_on 'Ordens de serviço'
      end

      click_on 'Criar ordem de serviço'

      expect(current_path).to eq new_service_order_path 
      within 'form' do
        expect(page).to have_content 'Dados do remetente'
        expect(page).to have_field 'Endereço do remetente'
        expect(page).to have_field 'CEP do remetente'

        expect(page).to have_content 'Dados da carga'
        expect(page).to have_field 'Altura do pacote'
        expect(page).to have_field 'Largura do pacote'
        expect(page).to have_field 'Profundidade do pacote'
        expect(page).to have_field 'Peso do pacote'

        expect(page).to have_content 'Dados do destinatário'
        expect(page).to have_field 'Nome do destinatário'
        expect(page).to have_field 'Endereço do destinatário'
        expect(page).to have_field 'CEP do destinatário'
        expect(page).to have_field 'Distância'
        expect(page).to have_button 'Enviar'
      end
    end

    it 'with success' do 
      login_as admin, scope: :user
      visit new_service_order_path

      fill_in 'Endereço do remetente', with: 'Av. Das Palmas, 1800'
      fill_in 'CEP do remetente', with: '60337683'

      fill_in 'Altura do pacote', with: '30'
      fill_in 'Largura do pacote', with: '40'
      fill_in 'Profundidade do pacote', with: '10'
      fill_in 'Peso do pacote', with: '100'

      fill_in 'Nome do destinatário', with: 'Paola Do Paolaverso'
      fill_in 'Endereço do destinatário', with: 'Av. Das Palmas, 1799'
      fill_in 'CEP do destinatário', with: '60337683'
      fill_in 'Distância', with: '10'
      click_on 'Enviar'

      expect(current_path).to eq service_orders_path
      expect(page).to have_content 'Ordem de serviço criada com sucesso'
      expect(page).to have_content 'Endereço do remetente: Av. Das Palmas, 1800'
      expect(page).to have_content 'Nome do destinatário: Paola Do Paolaverso'
      expect(page).to have_content 'Endereço do destinatário: Av. Das Palmas, 1799'
      expect(page).to have_content '10 metros'
    end

    it 'and dont fill all fields' do 
      login_as admin, scope: :user
      visit new_service_order_path

      fill_in 'Endereço do remetente', with: ''
      fill_in 'CEP do remetente', with: ''
      fill_in 'Endereço do destinatário', with: ''
      click_on 'Enviar'

      expect(current_path).to eq service_orders_path
      expect(page).to have_content 'Ordem de serviço não foi criada'
      expect(page).to have_content 'Verifique os erros abaixo:'
      expect(page).to have_content 'Endereço do remetente não pode ficar em branco'
      expect(page).to have_content 'CEP do remetente não pode ficar em branco'
      expect(page).to have_content 'Endereço do destinatário não pode ficar em branco'
    end

    it 'and return to home page' do 
      login_as admin, scope: :user
      visit new_service_order_path
      click_on 'Início'

      expect(current_path).to eq root_path
    end
  end

end