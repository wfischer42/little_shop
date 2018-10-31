class Admin::OrdersController < Admin::BaseController
  def index
    @orders = Order.all
  end

  def cancel
    @order = Order.find(params[:order_id])
    @order.update(status: :canceled)
    @orders = Order.all
    render :show
  end
end
