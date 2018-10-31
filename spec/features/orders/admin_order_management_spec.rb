# require 'rails_helper'
#
# describe 'Admin order privileges' do
#   before(:all) do
#     binding.pry
#     @admin = create(:user, role: :admin)
#   end
#   describe '/orders page (all-orders index)' do
#     before do
#       allow_any_instance_of(ApplicationController)
#         .to receive(:current_user).and_return(@admin)
#       order_items = create(:order_item)
#       visit admin_orders_path
#     end
#     let(:order) { Order.first}
#     describe 'order info blocks' do
#       describe 'Pending orders' do
#         subject { page.find("#order-#{order.id}-info") }
#         it { is_expected.to have_button  "Cancel Order" }
#       end
#       describe 'After pending order is cancelled' do
#         before { click_on "Cancel Order" }
#         subject { page.find("#order-#{order.id}-info") }
#         it { is_expected.to_not have_button  "Cancel Order" }
#         it { is_expected.to have_content "Order status: canceled" }
#       end
#     end
#   end
#
#   describe '/merchant/:id page (profile/dashboard)' do
#     before(:all) do
#       binding.pry
#       @merch = create(:user, role: :merchant)
#       items = create_list(:item, 5, merchant: @merch)
#       5.times { |n| order_items = create(:order_item, item: items[n]) }
#     end
#     before do
#       allow_any_instance_of(ApplicationController)
#         .to receive(:current_user).and_return(@admin)
#       visit admin_merchant_path(@merch)
#     end
#     context 'links to merchant orders' do
#       it { is_expected.to have_link 'View Orders'}
#       # subject { click_on 'View Orders'; page }
#     end
#     after(:all) do
#       binding.pry
#     end
#   end
# end
