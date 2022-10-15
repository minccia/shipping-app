User.destroy_all 

User.create!(name: 'common', email: 'common@sistemadefrete.com.br', password: '1234567')
User.create!(name: 'admin', email: 'admin@sistemadefrete.com.br', password: '1234567', role: :admin)

TransportModality.destroy_all
DistancePriceTable.destroy_all 
WeightPriceTable.destroy_all
TableEntry.destroy_all

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

Vehicle.create!(license_plate: 'ZDN4B52',
                brand_name: 'Chevrolet',
                vehicle_type: 'Carreta',
                fabrication_year: '2005',
                maximum_capacity: '800',
                transport_modality: trans_mod)

TableEntry.create!(first_interval: 0, second_interval: 1, value: 0.5, weight_price_table_id: trans_mod.weight_price_table.id)
TableEntry.create!(first_interval: 1, second_interval: 2, value: 1.0, weight_price_table_id: trans_mod.weight_price_table.id)
TableEntry.create!(first_interval: 2, second_interval: 3, value: 1.5, weight_price_table_id: trans_mod.weight_price_table.id)
TableEntry.create!(first_interval: 3, second_interval: 4, value: 2.0, weight_price_table_id: trans_mod.weight_price_table.id)

TableEntry.create!(first_interval: 0, second_interval: 20, value: 5, distance_price_table_id: trans_mod.distance_price_table.id)
TableEntry.create!(first_interval: 20, second_interval: 40, value: 10, distance_price_table_id: trans_mod.distance_price_table.id)
TableEntry.create!(first_interval: 40, second_interval: 60, value: 15, distance_price_table_id: trans_mod.distance_price_table.id)
TableEntry.create!(first_interval: 60, second_interval: 80, value: 20, distance_price_table_id: trans_mod.distance_price_table.id)