class Merchant::OrdersController < Merchant::BaseController
  def index
    @merc = User.find(current_user.id)
    @orders = @merc.merchant_orders.uniq
  end

  def show
    @merc = User.find(current_user.id)
    @order = Order.find(params[:id])
    @items = @order.items.where(user_id: @merc.id)
    @order_items = OrderItem.for_order_from_merchant(@merc.id, @order.id)
  end

end
