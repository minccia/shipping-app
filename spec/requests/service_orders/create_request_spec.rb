require 'rails_helper'

describe 'User create service order' do 
  it 'unless it is not authenticated as an admin' do 
    user = FactoryBot.create(:user)

    login_as user 
    post '/service_orders', params: { service_order: { package_height: 10 } }

    expect(response).to redirect_to root_path
  end
end