class OrdersController < ApplicationController
  def index
    @orders = current_user.orders
    
  end

  def create
    new_order = Order.create(user: current_user)
    new_order.add_cart_items(cart.items)
    if new_order.id
      session[:cart] = nil
    end
    redirect_to profile_orders_path
  end

  def cancel
    @order = Order.find(params[:order_id])
    @order.update(status: :canceled)
    @orders = Order.all
    render :show
  end

  def show
    @order = Order.find(params[:id])
  end
end
