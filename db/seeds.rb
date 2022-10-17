User.destroy_all 

User.create!(name: 'common', email: 'common@sistemadefrete.com.br', password: '1234567')
User.create!(name: 'admin', email: 'admin@sistemadefrete.com.br', password: '1234567', role: :admin)

TransportModality.destroy_all
DistancePriceTable.destroy_all 
WeightPriceTable.destroy_all
TableEntry.destroy_all
Vehicle.destroy_all 

expresso = TransportModality.create!(name: 'Expresso', 
                                      maximum_distance: 100,
                                      maximum_weight: 25,
                                      fee: 59.9)

TableEntry.create!(first_interval: 0, second_interval: 10, value: 5, weight_price_table_id: expresso.weight_price_table.id)
TableEntry.create!(first_interval: 11, second_interval: 20, value: 10, weight_price_table_id: expresso.weight_price_table.id)
TableEntry.create!(first_interval: 21, second_interval: 30, value: 1.5, weight_price_table_id: expresso.weight_price_table.id)
TableEntry.create!(first_interval: 31, second_interval: 40, value: 2.0, weight_price_table_id: expresso.weight_price_table.id)

TableEntry.create!(first_interval: 0, second_interval: 20, value: 5, distance_price_table_id: expresso.distance_price_table.id)
TableEntry.create!(first_interval: 20, second_interval: 40, value: 10, distance_price_table_id: expresso.distance_price_table.id)
TableEntry.create!(first_interval: 40, second_interval: 60, value: 15, distance_price_table_id: expresso.distance_price_table.id)
TableEntry.create!(first_interval: 60, second_interval: 80, value: 20, distance_price_table_id: expresso.distance_price_table.id)

TableEntry.create!(first_interval: 0, second_interval: 50, value: 24, freight_table_id: expresso.freight_table.id)
TableEntry.create!(first_interval: 50, second_interval: 100, value: 72, freight_table_id: expresso.freight_table.id)

Vehicle.create!(license_plate: 'ABC1D23',
    brand_name: 'Fiat',
    vehicle_type: 'Van',
    fabrication_year: '2010',
    maximum_capacity: '500',
    transport_modality: expresso)

Vehicle.create!(license_plate: 'ZDN4B52',
    brand_name: 'Chevrolet',
    vehicle_type: 'Carreta',
    fabrication_year: '2005',
    maximum_capacity: '800',
    transport_modality: expresso)

busao_do_joao = TransportModality.create!(name: 'Busão do João', 
                                          maximum_distance: 9999999,
                                          maximum_weight: 999999,
                                          fee: 0.1)

TableEntry.create!(first_interval: 0, second_interval: 999999, value: 0.1, weight_price_table_id: busao_do_joao.weight_price_table.id)
TableEntry.create!(first_interval: 0, second_interval: 9999999, value: 0.1, distance_price_table_id: busao_do_joao.distance_price_table.id)
TableEntry.create!(first_interval: 0, second_interval: 9999999, value: 24, freight_table_id: busao_do_joao.freight_table.id)

Vehicle.create!(license_plate: 'JOAOS2CHEIROSO',
    brand_name: 'Campus Code Tecnologias Automotivas LTDA',
    vehicle_type: 'Banco Foguete',
    fabrication_year: '2022',
    maximum_capacity: '99999',
    transport_modality: busao_do_joao)


StartedServiceOrder.destroy_all
ServiceOrder.destroy_all 

ServiceOrder.create!(
                     sender_full_address: 'Av Das Palmas, 100',
                     sender_zip_code: '60337640',
                     package_height: 100,
                     package_width: 70,
                     package_depth: 10,
                     package_weight: 20,
                     receiver_name: 'Paola Carossella',
                     receiver_full_address: 'Rua das Laranjeiras, 50',
                     receiver_zip_code: '60123456',
                     distance: 80
                    )