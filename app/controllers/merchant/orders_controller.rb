class Merchant::OrdersController < Merchant::BaseController

  def index
    @merc = User.find(current_user.id)
    @orders = @merc.merchant_orders.uniq
  end

  def show
    @order = Order.find(params[:id])
  end

  def cancel
    @order = Order.find(params[:order_id])
    @order.update(status: :canceled)
    @orders = Order.all
    render :show
  end
end
