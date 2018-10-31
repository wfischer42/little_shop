class Admin::ItemsController < Admin::BaseController

  def update
    item = Item.find(params[:id])
    if params[:attribute] == 'active'
      if item.active?
        item.update(active: false)
        flash[:notice] = "#{item.name} is no longer for sale."
        redirect_to items_path
      else
        item.update(active: true)
        flash[:notice] = "#{item.name} is back on the market."
        redirect_to items_path
      end
    else
      if item.update(item_params)
        flash[:success] = "Item Updated"
        redirect_to merchant_items_path
      else
        flash[:notice] = "Error, missing field. Please try again"
        redirect_to edit_merchant_item_path(item)
      end
    end
  end
end
