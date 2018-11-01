require 'rails_helper'

describe 'merchant visits order show page' do
  describe 'and fulfills order item' do
    it 'changes order item fulfilled status and updates inventory' do
      merchant = create(:user, role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)
      user = create(:user)
      item_1 = create(:item, user: merchant, inventory_count: 25)
      item_2 = create(:item, user: merchant)
      item_3 = create(:item, user: merchant)

      order_1 = create(:order, user: user)

      order_items_1 = create(:order_item, order: order_1, item: item_1, item_quantity: 10)
      order_items_2 = create(:order_item, order: order_1, item: item_2)
      order_items_3 = create(:order_item, order: order_1, item: item_3, item_quantity: 3)

      visit merchant_order_path(order_1)

      expect(page).to have_button("Fulfill")
      first(:button, "Fulfill").click
      expect(current_path).to eq(merchant_order_path(order_1))
      expect(page).to have_content("Item Fulfilled")
      expect(OrderItem.find(order_items_1.id).fulfilled).to eq(true)
      expect(Item.find(item_1.id).inventory_count).to eq(15)
    end

    describe 'the associated order' do
      before do
        order = create(:order)
        merchant = create(:user, role: :merchant)
        create(:order_item, order: order, fulfilled: false,
               item: create(:item, inventory_count: 10000, user: merchant))
        create(:order_item, order: order, fulfilled: true)

        allow_any_instance_of(ApplicationController)
          .to receive(:current_user).and_return(merchant)
      end

      let(:order)       { Order.first}
      let(:unfulfilled) { OrderItem.first }
      let(:merchant)    { User.find_by(role: :merchant)}

      context 'when all other order items are fulfilled' do
        it 'the order is also fulfilled' do
          visit merchant_order_path(order)
          first(:button, "Fulfill").click

          expect(page).to have_content("Order status: fulfilled")
        end
      end

      context 'when some items are left unfulfilled' do
        before do
          create(:order_item, order: order, fulfilled: false)
        end

        it 'the order is not also fulfilled' do
          visit merchant_order_path(order)
          first(:button, "Fulfill").click

          expect(page).to have_content("Order status: pending")
        end
      end
    end
  end
end
