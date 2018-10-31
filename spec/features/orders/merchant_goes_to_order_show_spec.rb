require 'rails_helper'

describe 'merchant visits order show' do
  it 'shows information about the order ' do
    merchant = create(:user, role: 1)
    merchant_2 = create(:user, role: 1)
    user = create(:user)
    item_1 = create(:item, user: merchant)
    item_2 = create(:item, user: merchant)
    item_3 = create(:item, user: merchant)
    item_4 = create(:item, user: merchant_2)

    order_1 = create(:order, user: user)
    order_2 = create(:order, user: user)

    order_items_1 = create(:order_item, order: order_1, item: item_1)
    order_items_2 = create(:order_item, order: order_1, item: item_2)
    order_items_3 = create(:order_item, order: order_1, item: item_3)
    order_items_3 = create(:order_item, order: order_1, item: item_4)

    visit merchant_order_path(order_1)

    expect(page).to have_link(item_1.name)
    expect(page).to have_link(item_2.name)
    expect(page).to have_link(item_3.name)
    expect(page).to_not have_content(item_4.name)
    expect(page).to have_content(item_1.price)
    expect(page).to have_content(item_2.price)
    expect(page).to have_content(item_3.price)
    expect(page).to_not have_content(item_4.price)


  end
end
