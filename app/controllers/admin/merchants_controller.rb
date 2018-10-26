class Admin::MerchantsController < Admin::BaseController

  def show
    @merchant = User.find(params[:id])
  end

  def update
    merchant = User.find(params[:id])
    if merchant.active?
      merchant.update(active: false)
    else
      merchant.update(active: true)
    end
  end

end
