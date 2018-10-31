require 'rails_helper'

describe '/orders page for admin' do
  before do
    admin = create(:user, role: :admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    order_items = create(:order_item)
    puts Order.first.id
    visit admin_orders_path
  end
  let(:order) { Order.first}
  describe 'order info block' do
    context 'before cancelling' do
      subject { page.find("#order-#{order.id}-info") }
      it { is_expected.to have_button  "Cancel Order" }
    end
    context 'after cancelling' do
      before { click_on "Cancel Order" }
      subject { page.find("#order-#{order.id}-info") }
      it { is_expected.to_not have_button  "Cancel Order" }
      it { is_expected.to have_content "Order status: canceled" }
    end
  end
end
