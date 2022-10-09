User.destroy_all 

User.create!(name: 'common', email: 'common@sistemadefrete.com.br', password: '1234567')
User.create!(name: 'admin', email: 'admin@sistemadefrete.com.br', password: '1234567', role: :admin)

TransportModality.destroy_all

trans_mod = TransportModality.create!(name: 'Expresso', 
                                      maximum_distance: 100,
                                      maximum_weight: 25,
                                      fee: 59.9)

Vehicle.destroy_all 

Vehicle.create!(license_plate: 'ABC1D23',
                brand_name: 'Fiat',
                vehicle_type: 'Van',
                fabrication_year: '2010',
                maximum_capacity: '500',
                transport_modality: trans_mod)