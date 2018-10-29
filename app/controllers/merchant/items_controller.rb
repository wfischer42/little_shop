class Merchant::ItemsController < Merchant::BaseController

  def index
    @user = User.find(current_user.id)
    @controller = 'merchant/items'
    @items = Item.where(user_id: @user.id)

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
end
