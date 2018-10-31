require 'rails_helper'

RSpec.describe 'admin visits admin dashboard' do
  let(:orders)   { create_list(:order, 5) }

  it 'sees biggest spenders' do

    admin = create(:user, role: :admin)
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user).and_return(admin)

    extra_order = create(:order, user: orders[0].user)
    create(:order_item, order: orders[0], fulfilled: true, item_price: 10, item_quantity: 17)
    create(:order_item, order: orders[1], fulfilled: true, item_price: 190, item_quantity: 1)
    create(:order_item, order: orders[2], fulfilled: true, item_price: 30, item_quantity: 2)
    create(:order_item, order: orders[2], fulfilled: true, item_price: 60, item_quantity: 2)
    create(:order_item, order: orders[3], fulfilled: true, item_price: 40, item_quantity: 1)
    create(:order_item, order: orders[4], fulfilled: true, item_price: 50, item_quantity: 1)
    create(:order_item, order: orders[4], fulfilled: false, item_price: 60, item_quantity: 10)

    visit dashboard_path

    within('.top_3_spenders') do
      expect(page).to have_content(orders[1].user.name)
      expect(page).to have_content(orders[2].user.name)
      expect(page).to have_content(orders[0].user.name)
    end

  end

  it 'sees top states and top cities' do
    admin = create(:user, role: :admin)
    allow_any_instance_of(ApplicationController)
    .to receive(:current_user).and_return(admin)

    extra_order = create(:order, user: orders[0].user)
    create_list(:order_item, 3, order: orders[0], fulfilled: true)
    create_list(:order_item, 10, order: orders[1], fulfilled: true)
    create_list(:order_item, 4, order: orders[2], fulfilled: true)
    create_list(:order_item, 6, order: orders[3], fulfilled: true)
    create_list(:order_item, 7, order: orders[4], fulfilled: true)
    create_list(:order_item, 5, order: extra_order, fulfilled: true)
    create_list(:order_item, 4, order: orders[2], fulfilled: false)

    visit dashboard_path

    within('.top_3_states') do
      expect(page).to have_content(orders[1].user.state)
      expect(page).to have_content(orders[0].user.state)
      expect(page).to have_content(orders[4].user.state)
    end

    within('.top_3_cities') do
      expect(page).to have_content(orders[1].user.city)
      expect(page).to have_content(orders[0].user.city)
      expect(page).to have_content(orders[4].user.city)
    end

  end

  it 'sees highest order quantity order ids' do
    admin = create(:user, role: :admin)
    allow_any_instance_of(ApplicationController)
    .to receive(:current_user).and_return(admin)

    extra_order = create(:order, user: orders[0].user)
    create(:order_item, order: orders[0], fulfilled: true, item_quantity: 17)
    create(:order_item, order: orders[1], fulfilled: true, item_quantity: 10)
    create(:order_item, order: orders[2], fulfilled: true, item_quantity: 9)
    create(:order_item, order: orders[2], fulfilled: true, item_quantity: 9)
    create(:order_item, order: orders[3], fulfilled: true, item_quantity: 3)
    create(:order_item, order: orders[4], fulfilled: true, item_quantity: 1)
    create(:order_item, order: orders[4], fulfilled: false, item_quantity: 10)

    visit dashboard_path

    within('.top_3_orders_quantity') do
      expect(page).to have_content(orders[2].id)
      expect(page).to have_content(orders[0].id)
      expect(page).to have_content(orders[1].id)
    end
  end

  it 'sees most popular merchants' do
    admin = create(:user, role: :admin)
    allow_any_instance_of(ApplicationController)
    .to receive(:current_user).and_return(admin)

    @user_1 = create(:user)
    @user_2 = create(:user)
    @user_3 = create(:user)
    @user_4 = create(:user)

    @merchant_1 = create(:user, role: 1)
    @merchant_2 = create(:user, role: 1)
    @merchant_3 = create(:user, role: 1)
    @merchant_4 = create(:user, role: 1)
    @merchant_5 = create(:user, role: 1)
    @merchant_6 = create(:user, role: 1)
    @merchant_7 = create(:user, role: 1)

    @item_1, @item_2 = create_list(:item, 2, user: @merchant_1, price: 10000)
    @item_3, @item_4 = create_list(:item, 2, user: @merchant_2, price: 5000)
    @item_5, @item_6 = create_list(:item, 2, user: @merchant_3, price: 2500)
    @item_7, @item_8 = create_list(:item, 2, user: @merchant_4, price: 10)
    @item_9, @item_10 = create_list(:item, 2, user: @merchant_5, price: 5)
    @item_11, @item_12 = create_list(:item, 2, user: @merchant_6, price: 3)
    @item_13, @item_14 = create_list(:item, 2, user: @merchant_7, price: 1)

    @order_1, @order_2, @order_3 = create_list(:order, 3, status: 2, user: @user_1)

    @order_item_1 = create(:order_item, order: @order_1, item: @item_1, fulfilled: true, updated_at: Time.now + 2.hours, item_quantity: 9)
    @order_item_2 = create(:order_item, order: @order_1, item: @item_2, fulfilled: true, updated_at: Time.now + 2.hours, item_quantity: 9)
    @order_item_3 = create(:order_item, order: @order_1, item: @item_3, fulfilled: true, updated_at: Time.now + 3.hours, item_quantity: 11)
    @order_item_4 = create(:order_item, order: @order_1, item: @item_4, fulfilled: true, updated_at: Time.now + 3.hours, item_quantity: 11)
    @order_item_5 = create(:order_item, order: @order_1, item: @item_5, fulfilled: true, updated_at: Time.now + 4.hours, item_quantity: 12)
    @order_item_16 = create(:order_item, order: @order_1, item: @item_10, fulfilled: true, updated_at: Time.now + 6.hours, item_quantity: 10)

    @order_item_6 = create(:order_item, order: @order_2, item: @item_6, fulfilled: true, updated_at: Time.now + 4.hours, item_quantity: 12)
    @order_item_7 = create(:order_item, order: @order_2, item: @item_7, fulfilled: true, updated_at: Time.now + 5.hours, item_quantity: 15)
    @order_item_8 = create(:order_item, order: @order_2, item: @item_8, fulfilled: true, updated_at: Time.now + 5.hours, item_quantity: 15)
    @order_item_9 = create(:order_item, order: @order_2, item: @item_9, fulfilled: true, updated_at: Time.now + 6.hours, item_quantity: 10)
    @order_item_10 = create(:order_item, order: @order_2, item: @item_10, fulfilled: true, updated_at: Time.now + 6.hours, item_quantity: 10)

    @order_item_11 = create(:order_item, order: @order_3, item: @item_6, fulfilled: true, updated_at: Time.now + 4.hours, item_quantity: 10)
    @order_item_12 = create(:order_item, order: @order_3, item: @item_7, fulfilled: true, updated_at: Time.now + 5.hours, item_quantity: 15)
    @order_item_13 = create(:order_item, order: @order_3, item: @item_8, fulfilled: true, updated_at: Time.now + 5.hours, item_quantity: 15)
    @order_item_14 = create(:order_item, order: @order_3, item: @item_9, fulfilled: true, updated_at: Time.now + 6.hours, item_quantity: 20)
    @order_item_15 = create(:order_item, order: @order_3, item: @item_10, fulfilled: true, updated_at: Time.now + 6.hours, item_quantity: 20)

    visit dashboard_path

    within('.top_3_selling_merchants') do
      expect(page).to have_content(@merchant_1.name)
      expect(page).to have_content(@merchant_2.name)
      expect(page).to have_content(@merchant_3.name)
    end
  end
end
