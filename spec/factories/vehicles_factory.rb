FactoryBot.define do
  factory :vehicle do
    license_plate { Faker::Vehicle.license_plate }
    brand_name { Faker::Vehicle.manufacture }
    vehicle_type { Faker::Vehicle.car_type }
    fabrication_year { Faker::Vehicle.year }
    maximum_capacity { rand(500.3000) }
    transport_modality { FactoryBot.create(:transport_modality) }
    status { 0 }
  end
end
