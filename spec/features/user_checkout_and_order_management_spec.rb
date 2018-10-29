require 'rails_helper'

describe 'Order' do
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
  describe 'cart checkout' do
    describe 'redirects to orders page' do
      scenario { expect(page).to have_current_path(profile_orders_path) }
    end
    describe 'adds order entry with cart items' do
      scenario { expect(Order.last.items).to eq(@items)}
    end
  end
  describe 'show page for user' do
    context 'order details block' do
      let(:order) { Order.last }
      let(:grand_total) { "Total: $#{Order.last.grand_total}" }
      scenario { expect(page).to have_content(grand_total) }
      xscenario { expect(order_block).to have_content("Order status: pending") }
      xscenario { expect(order_block).to have_css("#cancel-order") }
    end
  end
end
