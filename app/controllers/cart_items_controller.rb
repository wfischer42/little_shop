class CartItemsController < ApplicationController

  def create
    item = Item.find(params[:item_id])
    cart.add_item_to_cart(item)
    session[:cart] = cart.data
    flash[:success] = "#{item.name} added!"
    redirect_to cart_path
  end

  def add_item
    item = Item.find(params[:id])
    cart.add_item_to_cart(item)
    session[:cart] = cart.data
    redirect_to cart_path
  end

  def minus_item
    item = Item.find(params[:id])
    cart.minus_item(item)
    session[:cart] = cart.data
    redirect_to cart_path
  end


  def index
    @cart_items = cart.items
  end

  def destroy
    if params[:item_id]
      item = Item.find(params[:item_id])
      cart.remove_item(item.id)
      redirect_to cart_path
    else
      session[:cart] = nil
      redirect_to cart_path
    end
  end


end
