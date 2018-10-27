class CartItemsController < ApplicationController

  def index

  end

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

end
