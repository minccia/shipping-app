FactoryBot.define do
  factory :price_line do
    first_interval { 1 }
    second_interval { 1 }
    price { 1.5 }
    distance_price_table { nil }
    weight_price_table { nil }
  end
end
