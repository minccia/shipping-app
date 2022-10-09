require 'rails_helper' 

describe 'vehicles/index.html.erb' do 
  context 'User view vehicles' do 
    it 'if authenticated as a common user' do 
      visit root_path
      within 'nav' do 
        click_on 'Veículos'
      end

      expect(current_path).to eq new_user_session_path
    end
  end
end