require 'rails_helper' 

describe 'vehicles/index.html.erb' do 
  let(:user) { FactoryBot.create(:user) }

  context 'User visit index page' do 
    it 'if authenticated as a common user' do 
      visit root_path
      within 'nav' do 
        click_on 'Veículos'
      end

      expect(current_path).to eq new_user_session_path
    end

    it 'and find a search bar' do 
      login_as user, scope: :user
      visit root_path 
      click_on 'Veículos'

      within 'article header' do 
        expect(page).to have_field 'Buscar Veículo'
        expect(page).to have_button 'Buscar'
      end
    end
    
  end
end