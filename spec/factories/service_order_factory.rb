require 'faker'

FactoryBot.define do 
  factory :service_order do 
    sender_full_address { "Rua #{ Faker::FunnyName.name }" }
    sender_zip_code  { (Array.new(8) { rand(1..10) }).join }
    package_height { rand(1..100) }
    package_width { rand(1..100) }
    package_depth { rand(1..100) }
    package_weight { rand(1..1000) }
    receiver_name { Faker::Artist.name }
    receiver_full_address { "Rua #{ Faker::FunnyName.name }" }
    receiver_zip_code { (Array.new(8) { rand(1..10) }).join }
    distance { rand(1000.10000) }
  end
end