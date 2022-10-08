FactoryBot.define do
  factory :user do
    name { Faker::FunnyName.name }
    email { "#{Faker::Artist.name.downcase.delete(' ')}@sistemadefrete.com.br" }
    password { SecureRandom.hex(8) }
  end
end
