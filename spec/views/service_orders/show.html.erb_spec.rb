require 'rails_helper'

describe 'service_orders/show.html.erb' do 
  context 'User view service order details' do 
    it 'reaching the details page' do 
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
      click_on 'Ordens de serviço'
      click_on 'Ordem de serviço <ABCDE12345678>'

      expect(current_path).to eq service_order_path(ServiceOrder.last.id)
      expect(page).to have_content 'Endereço do remetente: Av Das Palmas, 100'
      expect(page).to have_content 'CEP do remetente: 60334-120'
      expect(page).to have_content 'Dimensões do pacote: 10 x 10 x 10 centímetros'
      expect(page).to have_content 'Peso do pacote: 100 gramas'
      expect(page).to have_content 'Nome do destinatário: Paola Dobrotto'
      expect(page).to have_content 'Endereço do destinatário: Av Das Laranjeiras, 500'
      expect(page).to have_content 'CEP do destinatário: 60334-520'
      expect(page).to have_content '100 metros'
    end

    it 'and return to home page' do
      so = FactoryBot.create(:service_order)
      
      visit service_order_path(so.id)
      click_on 'Início'
  
      expect(current_path).to eq root_path
    end
  end

end