class Admin::OrdersController < Admin::BaseController
  def index
    @orders = Order.all
  end

  def cancel
    Order.find(params[:order_id]).update(status: :canceled)
    @orders = Order.all
    render :index
  end
end
