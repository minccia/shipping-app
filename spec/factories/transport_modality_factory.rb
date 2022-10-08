FactoryBot.define do
  factory :transport_modality do
    name { "MyString" }
    minimum_distance { 1 }
    maximum_distance { 1 }
    minium_weight { 1 }
    maximum_weight { 1 }
    fee { 1.5 }
  end
end
