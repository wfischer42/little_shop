require 'rails_helper'

describe 'Admin order privileges' do
  include ActionView::Helpers::NumberHelper
  before do
    admin = create(:user, role: :admin)
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user).and_return(admin)
  end
  describe '/orders page (all-orders index)' do
    before do
      order_items = create(:order_item)
      visit admin_orders_path
    end
    let(:order) { Order.first}
    describe 'order info blocks' do
      describe 'Pending orders' do
        subject { page.find("#order-#{order.id}-info") }
        it { is_expected.to have_button  "Cancel Order" }
      end
      describe 'After pending order is cancelled' do
        before { click_on "Cancel Order" }
        subject { page.find("#order-#{order.id}-info") }
        it { is_expected.to_not have_button  "Cancel Order" }
        it { is_expected.to have_content "Order status: canceled" }
      end
    end
  end

  describe 'merchant orders' do
    let(:merchs) { create_list(:user, 2, role: :merchant) }
    before do
      items = create_list(:item, 5, merchant: merchs[0])
      2.times { |n| order_items = create(:order_item, item: items[n]) }
      items = create_list(:item, 5, merchant: merchs[1])
      2.times { |n| order_items = create(:order_item, item: items[n]) }
      visit admin_merchant_path(merchs[0])
    end
    let(:orders) { Order.all}
    describe '/merchant/:id page (profile/dashboard)' do
      scenario { expect(page).to have_link 'View Orders'}
    end
    describe 'links to /merchant/:id/orders page' do
      subject { click_link 'View Orders'; page }
      it { is_expected.to have_current_path(admin_merchant_orders_path(merchs[0])) }
      it { is_expected.to have_css("#order-#{orders[0].id}-info")}
      it { is_expected.to have_css("#order-#{orders[1].id}-info")}
      it { is_expected.to_not have_css("#order-#{orders[2].id}-info")}
      it { is_expected.to_not have_css("#order-#{orders[3].id}-info")}
      it { is_expected.to have_content "#{orders[0].created_at}" }
      it { is_expected.to have_content "#{orders[0].updated_at}" }
      it { is_expected.to have_content "#{orders[0].unit_quantity}" }
      it { is_expected.to have_content "#{convert_to_currency(orders[0].grand_total)}" }
      it { is_expected.to have_content "#{orders[0].status}" }
    end
  end
end
