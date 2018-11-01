class Merchant::OrderItemsController < Merchant::BaseController

  def update
    order = Order.find(params[:order_id])
    @item = Item.find(params[:item_id])
    @order_item = OrderItem.find(params[:order_item_id])
    sustract = @item.inventory_count - @order_item.item_quantity
    @item.update!(inventory_count: sustract)
    @order_item.update(fulfilled: true)
    flash[:notice] = "Item Fulfilled"
    redirect_to merchant_order_path(order)
  end

end
