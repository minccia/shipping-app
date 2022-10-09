require 'rails_helper'

describe 'transport_modalities/edit.html.erb' do 
  context 'Admin user edit existing transport modality' do 
    it 'if authenticated' do 
      trans_mod = FactoryBot.create(:transport_modality)

      visit edit_transport_modality_path(trans_mod.id)

      expect(page).to have_content 'Você não possui acesso a esta página pois não é um admin'
    end
  end

end