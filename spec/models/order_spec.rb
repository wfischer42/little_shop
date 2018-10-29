require 'rails_helper'

RSpec.describe Order, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:order_items) }
  it { is_expected.to have_many(:items).through(:order_items) }
  it { is_expected.to validate_presence_of(:status) }
  it { expect(subject.status).to eq("pending")}

  describe 'Instance Methods' do
    describe '.add_order_items(items)' do
      before do
        @order = create(:order)
        @items = create_list(:item, 3)
        cart_items = []
        cart_items << CartItem.new(@items[0], 1)
        cart_items << CartItem.new(@items[1], 2)
        cart_items << CartItem.new(@items[2], 3)
        @order.add_cart_items(cart_items)
      end
      describe 'updates order.items' do
        subject { @order.items }
        it { is_expected.to eq(@items) }
      end
      describe 'updates order.order_items' do
        subject { @order.order_items }
        scenario { expect(subject[0].item_price).to eq(@items[0].price) }
        scenario { expect(subject.count).to eq(@items.count) }
      end
    end
  end
end
