require 'rails_helper'

describe 'post service_order_start' do 
    let(:user) { FactoryBot.create(:user) }
    it 'user sees transport mode prices on selection input' do
    service_order = FactoryBot.create(:service_order, distance: 80, package_weight: 20)
    trans_mod = TransportModality.create!(name: 'Ghetto', 
                                          maximum_distance: 100,
                                          maximum_weight: 25,
                                          fee: 12.9
                                        )
    vehicle = Vehicle.create!(
                              license_plate: 'ABC1D23',
                              brand_name: 'Fiat',
                              vehicle_type: 'Van',
                              fabrication_year: '2010',
                              maximum_capacity: '500',
                              transport_modality: trans_mod
                            )
    TableEntry.create!(first_interval: 11, second_interval: 20, value: 0.50, weight_price_table_id: trans_mod.weight_price_table.id)
    TableEntry.create!(first_interval: 60, second_interval: 80, value: 20, distance_price_table_id: trans_mod.distance_price_table.id)                                         
    TableEntry.create!(first_interval: 50, second_interval: 100, value: 72, freight_table_id: trans_mod.freight_table.id)

    login_as user, scope: :user
    visit service_order_path(service_order.id)

    expect(page).to have_content "#{trans_mod.name} - #{number_to_currency(trans_mod.so_execution_price(service_order), locale: 'pt-BR')} - #{trans_mod.so_execution_due_date(service_order).to_i}h (#{(trans_mod.so_execution_due_date(service_order)/24).to_i} Dias)"
    end
end
    