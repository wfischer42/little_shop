require 'rails_helper'

RSpec.describe Item, type: :model do
  it{ is_expected.to validate_presence_of(:name) }
  it{ is_expected.to validate_presence_of(:price) }
  it{ is_expected.to validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
  it{ is_expected.to validate_numericality_of(:inventory_count).is_greater_than_or_equal_to(0) }
  it{ is_expected.to validate_presence_of(:description) }
  it{ is_expected.to validate_presence_of(:img_url) }
  it{ is_expected.to belong_to(:merchant) }
  it{ is_expected.to have_many(:order_items) }
  it{ is_expected.to have_many(:orders).through(:order_items) }

  describe "Class Methods" do
    it '.most_popular' do
      @user_1 = create(:user)

      @item_1, @item_2, @item_3, @item_4, @item_5, @item_6, @item_7, @item_8, @item_9, @item_10 = create_list(:item, 10)

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

      expect(Item.most_popular).to eq([@item_10, @item_9, @item_8, @item_7, @item_6])
    end
  end

  describe 'Instance Method' do
    it 'Order Quantity' do
      merchant = create(:user, role: 1)
      merchant_2 = create(:user, role: 1)
      user = create(:user)

      item_1 = create(:item, user: merchant)
      item_2 = create(:item, user: merchant)
      item_3 = create(:item, user: merchant)
      item_4 = create(:item, user: merchant_2)

      order_1 = create(:order, user: user)
      order_2 = create(:order, user: user)

      order_items_1 = create(:order_item, order: order_1, item: item_1, item_quantity: 10)
      order_items_2 = create(:order_item, order: order_1, item: item_2)
      order_items_3 = create(:order_item, order: order_1, item: item_3, item_quantity: 3)
      order_items_3 = create(:order_item, order: order_1, item: item_4)

      expect(item_1.order_quantity(order_1)).to eq(10)
    end
  end
end
