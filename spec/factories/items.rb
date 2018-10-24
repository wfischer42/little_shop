FactoryBot.define do
  factory :item do
    user 
    name { "MyString" }
    price { "9.99" }
    inventory_count { 1 }
    description { "MyText" }
    img_url { "MyString" }
  end
end
