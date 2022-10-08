FactoryBot.define do
  factory :transport_modality do
    name { Faker::FunnyName.name }
    minimum_distance { rand(100..1000) }
    maximum_distance { rand(100..1000) }
    minimum_weight { rand(100..1000) }
    maximum_weight { rand(100..1000) }
    fee { rand(1..100).to_f }
  end
end
