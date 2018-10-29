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

  it '.remove_item' do
    item = create(:item)
    cart = Cart.new(nil)
    cart.add_item_to_cart(item)
    cart.remove_item(item.id)

    expect(cart.cart_count).to eq(0)
  end

  it '.minus_item' do
    item = create(:item)
    cart = Cart.new(nil)
    cart.add_item_to_cart(item)
    cart.add_item_to_cart(item)
    expect(cart.cart_count).to eq(2)

    cart.minus_item(item)
    expect(cart.cart_count).to eq(1)
  end

  it '.add_item_to_cart' do
    item = create(:item)
    cart = Cart.new(nil)
    expect(cart.cart_count).to eq(0)

    cart.add_item_to_cart(item)
    expect(cart.cart_count).to eq(1)
  end

  it '#items' do
    items = create_list(:item, 3, price: 2)
    cart = Cart.new(nil)
    items.each { |item| cart.add_item_to_cart(item) }

    expect(cart.items.first).to be_a_kind_of(CartItem)
  end

  it '#data' do
    item = create(:item)
    cart = Cart.new(nil)
    cart.add_item_to_cart(item)

    expect(cart.data).to eq({item.id.to_s => 1})
  end

end
