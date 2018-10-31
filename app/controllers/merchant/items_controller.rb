class Merchant::ItemsController < Merchant::BaseController

  def index
    @user = User.find(current_user.id)
    @controller = 'merchant/items'
    @items = Item.where(user_id: @user.id)
  end

  def new
    @item = Item.new()
    @url = merchant_items_path
  end

  def create
    @item = current_user.items.create(item_params)
    if @item.save
      flash[:success] = "#{@item.name} added to your items"
      redirect_to merchant_items_path
    else
      flash[:notice] = "Item not added"
      render :new
    end
  end

  def update
    item = Item.find(params[:id])
    if params[:attribute] == 'active'
      if item.active?
        item.update(active: false)
        flash[:notice] = "#{item.name} is no longer for sale."
        redirect_to merchant_items_path
      else
        item.update(active: true)
        flash[:notice] = "#{item.name} is back on the market."
        redirect_to merchant_items_path
      end
    end
  end


  private

  def item_params
    params.require(:item).permit(:name, :description, :img_url, :price, :inventory_count)
  end
end
