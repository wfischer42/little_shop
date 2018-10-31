class Merchant::OrderItemsController < Merchant::BaseController

  def update
    order = Order.find(params[:order_id])
    @order_item = OrderItem.specific_item(params[:order_id], params[:item_id])
    @order_item.update(fulfilled: true)
    flash[:notice] = "Item Fulfilled"
    redirect_to merchant_order_path(order)
  end

end
