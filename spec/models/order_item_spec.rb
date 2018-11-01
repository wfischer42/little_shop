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

  describe '#top_states' do
    let(:orders)   { create_list(:order, 5) }

    before do
      extra_order = create(:order, user: orders[0].user)
      create_list(:order_item, 3, order: orders[0], fulfilled: true)
      create_list(:order_item, 10, order: orders[1], fulfilled: true)
      create_list(:order_item, 4, order: orders[2], fulfilled: true)
      create_list(:order_item, 6, order: orders[3], fulfilled: true)
      create_list(:order_item, 7, order: orders[4], fulfilled: true)
      create_list(:order_item, 5, order: extra_order, fulfilled: true)
      create_list(:order_item, 4, order: orders[2], fulfilled: false)
    end

    subject(:result) do
      OrderItem.top_states.map do |r|
        r.state
      end
    end

    let(:expected) { [orders[1].user.state, orders[0].user.state, orders[4].user.state] }

    it { should eq expected }
  end

  describe '#top_cities' do
    let(:orders)   { create_list(:order, 5) }

    before do
      extra_order = create(:order, user: orders[0].user)
      create_list(:order_item, 3, order: orders[0], fulfilled: true)
      create_list(:order_item, 10, order: orders[1], fulfilled: true)
      create_list(:order_item, 4, order: orders[2], fulfilled: true)
      create_list(:order_item, 6, order: orders[3], fulfilled: true)
      create_list(:order_item, 7, order: orders[4], fulfilled: true)
      create_list(:order_item, 5, order: extra_order, fulfilled: true)
      create_list(:order_item, 4, order: orders[2], fulfilled: false)
    end

    subject(:result) do
      OrderItem.top_cities.map do |r|
        r.city
      end
    end

    let(:expected) { [orders[1].user.city, orders[0].user.city, orders[4].user.city] }

    it { should eq expected }
  end
end
