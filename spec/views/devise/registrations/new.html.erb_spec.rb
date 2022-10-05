require 'rails_helper'

describe 'devise/registrations/new.html.erb' do 
  context 'User sign up' do 
    it 'with success' do 
      visit root_path
      click_on 'Fazer Login'
      click_on 'Registrar-se'

      fill_in 'Nome', with: 'Paola'
      fill_in 'Email', with: 'paola@email.com'
      fill_in 'Senha', with: '12345678'
      fill_in 'Confirme sua senha', with: '12345678'
      click_on 'Registrar-se'

      expect(page).to have_button 'Sair'
      expect(page).to have_content 'Bem vindo! Você realizou seu registro com sucesso'
    end
  end

end