require 'rails_helper'

describe 'User starts a service_order' do 
  it 'unless its not authenticated' do 
    so = FactoryBot.create(:service_order)

    get "/service_orders/#{so.id}/start"

    expect(response).to redirect_to new_user_session_path
  end
end