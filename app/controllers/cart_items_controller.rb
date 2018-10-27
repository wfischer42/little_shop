class CartItemsController < ApplicationController

  def create
    item = Item.find(params[:item_id])
    cart.add_item_to_cart(item)
    session[:cart] = cart.data
    flash[:success] = "#{item.name} added!"
    redirect_to cart_path
  end

  def index
    @cart_items = cart.items
  end

  def destroy
    if params[:item_id]
      # flash[:notice] = "#{item.name} removed from cart. Add it back in here:#{view_context.link_to(" #{item.title}", item_path(item))}"
      item = Item.find(params[:item_id])
      cart.remove_item(item.id)
      redirect_to cart_path
    else
      session[:cart] = nil
      redirect_to cart_path
    end
  end


end
