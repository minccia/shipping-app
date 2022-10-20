require 'rails_helper' 

describe 'User view formulary for a new service order' do 
  it 'unless it is not authenticated as an admin' do 
    user = FactoryBot.create(:user)

    login_as user 
    get '/service_orders/new'

    expect(response).to redirect_to root_path
  end
end