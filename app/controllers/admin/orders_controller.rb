class Admin::OrdersController < Admin::BaseController
  def index
    @orders = Order.all
  end

  def show
    if params[:merchant_id]
      merchant = User.find(params[:merchant_id])
      @orders = merchant.merchant_orders
    elsif params[:user_id]
      @orders = User.find(params[:user_id]).orders
    else
      @orders = Order.all
    end
  end

  def cancel
    @order = Order.find(params[:order_id])
    @order.update(status: :canceled)
    @orders = Order.all
    render :show
  end
end
