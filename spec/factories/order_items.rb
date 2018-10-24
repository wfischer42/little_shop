FactoryBot.define do
  factory :order_item do
    item
    order
    sequence :item_quantity { |n| n }
    sequence :item_price { |n| n * 1.12 }
  end
end
