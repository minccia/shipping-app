require 'rails_helper'

describe 'devise/sessions/new.html.erb' do 
  context 'User authenticates' do 
    it 'with success' do 
      User.create!(name: 'Paola Dobrotto',
                   email: 'paola@sistemadefrete.com.br',
                   password: 'password')
      
      visit root_path 
      click_on 'Fazer Login'
  
      within 'form' do
        fill_in 'Email', with: 'paola@sistemadefrete.com.br' 
        fill_in 'Senha', with: 'password'
        click_on 'Fazer Login'
      end
      within 'nav' do 
        expect(page).not_to have_link 'Fazer Login'
        expect(page).to have_button 'Sair'
      end
      expect(page).to have_content 'Login efetuado com sucesso'
    end
  
    it 'and sign_out' do 
      User.create!(name: 'Paola Dobrotto',
                   email: 'paola@sistemadefrete.com.br',
                   password: 'password')
      
      visit new_user_session_path
  
      within 'form' do
        fill_in 'Email', with: 'paola@sistemadefrete.com.br' 
        fill_in 'Senha', with: 'password'
        click_on 'Fazer Login'
      end
      within 'nav' do 
        click_on 'Sair'
      end
      expect(page).to have_content 'Logout efetuado com sucesso'
      expect(page).not_to have_button 'Sair'
      expect(page).to have_link 'Fazer Login'
    end
  end

end