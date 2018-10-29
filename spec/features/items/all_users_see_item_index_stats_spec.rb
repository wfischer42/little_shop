require 'rails_helper'

RSpec.describe 'any user visits the item index page' do
  it 'sees the 5 most popular items' do
    user_1 = create(:user)

    item_1, item_2, item_3, item_4, item_5, item_6, item_7, item_8, item_9, item_10 = create_list(:item, 10)

    order_1, order_2 = create_list(:order, 2, status: 2, user: user_1)

    order_item_1 = create(:order_item, order: order_1, item: item_1)
    order_item_2 = create(:order_item, order: order_1, item: item_2)
    order_item_3 = create(:order_item, order: order_1, item: item_3)
    order_item_4 = create(:order_item, order: order_1, item: item_4)
    order_item_5 = create(:order_item, order: order_1, item: item_5)
    order_item_6 = create(:order_item, order: order_2, item: item_1)
    order_item_7 = create(:order_item, order: order_2, item: item_2)
    order_item_8 = create(:order_item, order: order_2, item: item_3)
    order_item_9 = create(:order_item, order: order_2, item: item_4)
    order_item_10 = create(:order_item, order: order_2, item: item_5)

    visit items_path

    within(".item_index_stats") do
    end
  end
end
