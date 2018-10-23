FactoryBot.define do
  factory :order do
    user { nil }
    status { 1 }
    total { "9.99" }
  end
end
