require 'rails_helper'

describe 'User finishs a service order' do 
  it 'unless it wasnt started' do 
    so = FactoryBot.create(:service_order)

    get "/service_orders/#{so.id}/finish", params: { service_order: { vehicle_id: 3 } }

    expect(response).to redirect_to root_path
  end

  it 'unless it was already finished' do 
    so = FactoryBot.create(:service_order, status: :finished)

    get "/service_orders/#{so.id}/finish", params: { service_order: { vehicle_id: 3 } }

    expect(response).to redirect_to root_path
  end
end