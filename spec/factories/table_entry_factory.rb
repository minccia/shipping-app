FactoryBot.define do 
  factory :table_entry do 
    first_interval { rand(1..100) }
    second_interval { rand(101..300) }
    value { rand(1..100) }

  end

end