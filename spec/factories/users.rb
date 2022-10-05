FactoryBot.define do
  factory :user do
    name { Faker::FunnyName.name }
    email { Faker::Internet.email }
    password { SecureRandom.hex(8) }
  end
end
