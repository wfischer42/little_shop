FactoryBot.define do
  factory :order_item do
    item { nil }
    order { nil }
    item_quantity { 1 }
    item_price { "9.99" }
  end
end
