require 'rails_helper'

RSpec.describe 'any user visits the item index page' do
  before do
    @user_1 = create(:user)

    @item_1, @item_2, @item_3, @item_4, @item_5, @item_6, @item_7, @item_8, @item_9, @item_10 = create_list(:item, 10)

    @order_1, @order_2, @order_3 = create_list(:order, 3, status: 2, user: @user_1)

    @order_item_1 = create(:order_item, order: @order_1, item: @item_1)
    @order_item_2 = create(:order_item, order: @order_1, item: @item_2)
    @order_item_3 = create(:order_item, order: @order_1, item: @item_3)
    @order_item_4 = create(:order_item, order: @order_1, item: @item_4)
    @order_item_5 = create(:order_item, order: @order_1, item: @item_5)
    @order_item_16 = create(:order_item, order: @order_1, item: @item_10)

    @order_item_6 = create(:order_item, order: @order_2, item: @item_6)
    @order_item_7 = create(:order_item, order: @order_2, item: @item_7)
    @order_item_8 = create(:order_item, order: @order_2, item: @item_8)
    @order_item_9 = create(:order_item, order: @order_2, item: @item_9)
    @order_item_10 = create(:order_item, order: @order_2, item: @item_10)

    @order_item_11 = create(:order_item, order: @order_3, item: @item_6)
    @order_item_12 = create(:order_item, order: @order_3, item: @item_7)
    @order_item_13 = create(:order_item, order: @order_3, item: @item_8)
    @order_item_14 = create(:order_item, order: @order_3, item: @item_9)
    @order_item_15 = create(:order_item, order: @order_3, item: @item_10)

    visit items_path
  end

  it 'sees the 5 most popular items' do
    within(".item_index_stats .most_popular_items") do
      expect(page).to have_content("#{@item_10.name}")
      expect(page).to have_content("#{@item_9.name}")
      expect(page).to have_content("#{@item_8.name}")
      expect(page).to have_content("#{@item_7.name}")
      expect(page).to have_content("#{@item_6.name}")
    end
  end

  it 'does not see items that arent most popular' do
    within(".item_index_stats .most_popular_items") do
      expect(page).to_not have_content("#{@item_2.name}")
      expect(page).to_not have_content("#{@item_3.name}")
      expect(page).to_not have_content("#{@item_4.name}")
      expect(page).to_not have_content("#{@item_5.name}")
    end
  end

  it 'sees top 5 most popular merchant' do
    within(".item_index_stats .most_popular_merchants") do
      

    end
  end
end
