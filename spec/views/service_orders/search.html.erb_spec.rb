require 'rails_helper'

describe 'service_orders/search.html.erb' do 
  context 'User search for service orders on application nav' do 
    it 'with success' do 
    allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('ABCDE12345678')    
    so = FactoryBot.create(:service_order)
    
    visit root_path 
    fill_in 'Buscar ordem de serviço', with: 'ABC'
    click_on 'Buscar'

    expect(page).to have_content 'Ordem de serviço <ABCDE12345678>'
    expect(page).to have_content "Data de início: #{ (Date.today+1.day).strftime("%d/%m/%Y") }"
    end
  end
end