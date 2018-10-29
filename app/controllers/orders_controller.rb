class OrdersController < ApplicationController
  def index
  end

  def create
    new_order = Order.create(user: current_user)
    new_order.add_cart_items(cart.items)
    redirect_to profile_orders_path
  end
end
