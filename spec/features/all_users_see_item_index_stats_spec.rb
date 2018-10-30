require 'rails_helper'

RSpec.describe 'any user visits the item index page' do
  before do
    @user_1 = create(:user)
    @merchant_1 = create(:user, role: 1)
    @merchant_2 = create(:user, role: 1)
    @merchant_3 = create(:user, role: 1)
    @merchant_4 = create(:user, role: 1)
    @merchant_5 = create(:user, role: 1)
    @merchant_6 = create(:user, role: 1)
    @merchant_7 = create(:user, role: 1)

    @item_1, @item_2 = create_list(:item, 2, user: @merchant_1)
    @item_3, @item_4 = create_list(:item, 2, user: @merchant_2)
    @item_5, @item_6 = create_list(:item, 2, user: @merchant_3)
    @item_7, @item_8 = create_list(:item, 2, user: @merchant_4)
    @item_9, @item_10 = create_list(:item, 2, user: @merchant_5)

    @order_1, @order_2, @order_3 = create_list(:order, 3, status: 2, user: @user_1)

    @order_item_1 = create(:order_item, order: @order_1, item: @item_1, fulfilled: true)
    @order_item_2 = create(:order_item, order: @order_1, item: @item_2, fulfilled: true)
    @order_item_3 = create(:order_item, order: @order_1, item: @item_3, fulfilled: true)
    @order_item_4 = create(:order_item, order: @order_1, item: @item_4, fulfilled: true)
    @order_item_5 = create(:order_item, order: @order_1, item: @item_5, fulfilled: true)
    @order_item_16 = create(:order_item, order: @order_1, item: @item_10, fulfilled: true)

    @order_item_6 = create(:order_item, order: @order_2, item: @item_6, fulfilled: true)
    @order_item_7 = create(:order_item, order: @order_2, item: @item_7, fulfilled: true)
    @order_item_8 = create(:order_item, order: @order_2, item: @item_8, fulfilled: true)
    @order_item_9 = create(:order_item, order: @order_2, item: @item_9, fulfilled: true)
    @order_item_10 = create(:order_item, order: @order_2, item: @item_10, fulfilled: true)

    @order_item_11 = create(:order_item, order: @order_3, item: @item_6, fulfilled: true)
    @order_item_12 = create(:order_item, order: @order_3, item: @item_7, fulfilled: true)
    @order_item_13 = create(:order_item, order: @order_3, item: @item_8, fulfilled: true)
    @order_item_14 = create(:order_item, order: @order_3, item: @item_9, fulfilled: true)
    @order_item_15 = create(:order_item, order: @order_3, item: @item_10, fulfilled: true)

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

  it 'sees the top 5 most popular merchants' do
    within(".item_index_stats .most_popular_merchants") do
      expect(page).to have_content("#{@merchant_5.name}")
      expect(page).to have_content("#{@merchant_4.name}")
      expect(page).to have_content("#{@merchant_3.name}")
      expect(page).to have_content("#{@merchant_2.name}")
      expect(page).to have_content("#{@merchant_1.name}")
    end
  end

  it 'does not see merchants who are not in top 5 most popular' do
    within(".item_index_stats .most_popular_merchants") do
      expect(page).to_not have_content("#{@merchant_6.name}")
      expect(page).to_not have_content("#{@merchant_7.name}")
    end
  end

end
