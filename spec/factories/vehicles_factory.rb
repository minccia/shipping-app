FactoryBot.define do
  factory :vehicle do
    license_plate { "MyString" }
    brand_name { "MyString" }
    type { "" }
    fabrication_year { "MyString" }
    maximum_capacity { "MyString" }
    status { 1 }
  end
end
