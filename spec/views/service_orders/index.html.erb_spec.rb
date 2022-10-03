require 'rails_helper'

describe 'service_orders/index.html.erb' do 
  context 'User view service orders' do 
    it 'with success' do 
      allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('ABCDE12345678')
      ServiceOrder.create(
                          sender_full_address: 'Av Das Palmas, 100',
                          sender_zip_code: '60334120',
                          package_height: 10, package_width: 10,
                          package_depth: 10, package_weight: 100,
                          receiver_name: 'Paola Dobrotto',
                          receiver_full_address: 'Av Das Laranjeiras, 500',
                          receiver_zip_code: '60334520',
                          distance: 100
                        )

      visit root_path 

      within 'nav' do
        click_on 'Ordens de serviço'
      end

      expect(page).to have_content 'Ordem de serviço <ABCDE12345678>'
      expect(page).to have_content 'Endereço do remetente: Av Das Palmas, 100'
      expect(page).to have_content 'Nome do destinatário: Paola Dobrotto'
      expect(page).to have_content 'Endereço do destinatário: Av Das Laranjeiras, 500'
      expect(page).to have_content 'Distância: 100 metros'
    end

    it 'unless there arent any service orders' do 
      visit service_orders_path 

      expect(page).to have_content 'Não há ordens de serviço ainda'
    end

    it 'and return to home page' do 
      visit service_orders_path
      click_on 'Início'

      expect(current_path).to eq root_path
    end
  end
  
end