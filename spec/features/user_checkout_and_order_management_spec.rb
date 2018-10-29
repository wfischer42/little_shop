require 'rails_helper'

describe 'Order' do
  describe 'creation' do
    before do
      user = create(:user)
      @items = create_list(:item, 3)
      cart = Cart.new(nil)
      @items.each { |item| cart.add_item_to_cart(item) }
      allow_any_instance_of(ApplicationController).to receive(:cart).and_return(cart)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit cart_path
      click_button("checkout")
    end
    describe 'user check out redirects to orders page' do
      scenario { expect(page).to have_current_path(profile_orders_path) }
      it {binding.pry}
      context 'order details block' do
        let(:order) { Order.last }
        xscenario  { expect(page).to have_content(grand_total) }
        xscenario { expect(order_block).to have_content("Order status: pending") }
        xscenario { expect(order_block).to have_css("#cancel-order") }
      end
    end
  end
end