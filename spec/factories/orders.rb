FactoryBot.define do
  factory :order do
    status { 0 }
    user
  end
  factory :order_with_item, parent: :order do
    order_items { [create(:order_item)] }
  end
end
