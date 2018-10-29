require 'rails_helper'

RSpec.describe Cart do
  it '.cart_count' do
    cart = Cart.new("1" => 2, "2" => 3)

    expect(cart.cart_count).to eq(5)
  end

  it '.cart_total' do
    items = create_list(:item, 3, price: 2)
    cart = Cart.new(nil)
    items.each { |item| cart.add_item_to_cart(item) }

    expect(cart.cart_total).to eq(6.0)
  end
end
