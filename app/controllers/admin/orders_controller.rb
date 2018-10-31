class Admin::OrdersController < Admin::BaseController
  def index
    if params[:merchant_id]
      merchant = User.find(params[:merchant_id])
      @orders = merchant.merchant_orders
    elsif params[:user_id]
      
    else
      @orders = Order.all
    end
  end

  def cancel
    Order.find(params[:order_id]).update(status: :canceled)
    @orders = Order.all
    render :index
  end
end
