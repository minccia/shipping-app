require 'rails_helper'

describe 'home/index.html.erb' do 
  context 'User view home_page' do 
    it 'with success' do 
      visit root_path 

      expect(page).to have_content 'Paola Fretagens'
      expect(current_path).to eq root_path
    end
  end
end