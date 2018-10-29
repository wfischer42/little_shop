class ItemsController < ApplicationController

  def index
    @items = Item.where.not(active: false)
  end

  def show
    @item = Item.find(params[:id])
  end
end
