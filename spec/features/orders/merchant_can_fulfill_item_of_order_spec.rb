require 'rails_helper'

describe 'merchant visits order show page' do
  it 'Allows merchant to fulfill an order ' do
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
end
