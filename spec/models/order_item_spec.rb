require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  it {is_expected.to belong_to(:order) }
  it {is_expected.to belong_to(:item) }
  it {is_expected.to validate_presence_of(:item_quantity) }
  it {is_expected.to validate_presence_of(:item_price) }
  it {is_expected.to validate_numericality_of(:item_quantity).is_greater_than(0) }
  it {is_expected.to validate_numericality_of(:item_price).is_greater_than_or_equal_to(0) }

  describe "Class Methods" do
    it "for_order_from_merchant" do
      merchant = create(:user, role: 1)
      user = create(:user)
      item_1 = create(:item, user: merchant, inventory_count: 25)
      item_2 = create(:item, user: merchant, inventory_count: 25)
      order_1 = create(:order, user: user)
      order_2 = create(:order, user: user)
      order_item_1 = create(:order_item, order: order_1, item: item_1, item_quantity: 10)
      order_item_2 = create(:order_item, order: order_2, item: item_2)

    expect(OrderItem.for_order_from_merchant(merchant.id, order_1.id).last).to eq(order_item_1)
    end
  end
end
