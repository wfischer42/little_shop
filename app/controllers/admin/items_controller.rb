class Admin::ItemsController < Admin::BaseController

  def index
    @items = Item.where(user_id: params[:merchant_id])
    @merchant = User.find(params[:merchant_id])
    @new_item = Item.new
    @display = params[:display]
  end

  def show
    @item = Item.find(params[:id])
    @merchant = User.find(params[:merchant_id])
    @display = params[:display]
  end

  def new
    @merchant = User.find(params[:merchant_id])
    @new_item = Item.new()
  end

  def create
    @merchant = User.find(params[:merchant_id])
    @new_item = @merchant.items.create(item_params)
    if @new_item.save
      flash[:success] = "#{@new_item.name} added to #{@merchant.name}'s items"
      redirect_to admin_merchant_items_path(@merchant)
    else
      flash[:notice] = "Item not able to be added, please review form"
      render :new
    end
  end

  def update
    item = Item.find(params[:id])
    merchant = User.find(params[:merchant_id])
    if params[:attribute] == 'active'
      if item.active?
        item.update(active: false)
        flash[:notice] = "#{item.name} is no longer for sale."
        redirect_to admin_merchant_items_path(merchant)
      else
        item.update(active: true)
        flash[:notice] = "#{item.name} is back on the market."
        redirect_to admin_merchant_items_path(merchant)
      end
    else
      if item.update(item_params)
        flash[:success] = "Item Updated"
        redirect_to admin_merchant_items_path(merchant)
      else
        flash[:notice] = "Error, missing field. Please try again"
        redirect_to admin_merchant_item_path(merchant.id, item.id, html_options = {display: "edit"})
      end
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :price, :inventory_count)
  end

end
