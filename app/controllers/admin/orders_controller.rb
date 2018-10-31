class Admin::OrdersController < Admin::BaseController
  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end
  
  def cancel
    Order.find(params[:order_id]).update(status: :canceled)
    @orders = Order.all
    render :show
  end
end
