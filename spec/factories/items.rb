FactoryBot.define do
  factory :item do
    user { create(:user, role: "merchant") }
    sequence :name              { |n| "Item #{n}"}
    sequence :price             { |n| n * 1.01 }
    sequence :inventory_count   { |n| n }
    sequence :description       { |n| "Description #{n}" }
    sequence :img_url           { |n| "www.example.com/#{n}" }
  end
end
