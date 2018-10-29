require 'rails_helper'

RSpec.describe Cart do
  it '.cart_count' do
    cart = Cart.new("1" => 2, "2" => 3)

    expect(cart.cart_count).to eq(5)
  end
end
