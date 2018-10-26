class Admin::MerchantsController < Admin::BaseController

  def show
    @merchant = User.find(params[:id])
  end

  def update
    merchant = User.find(params[:id])
    if merchant.active?
      merchant.update(active: false)
      redirect_to admin_merchants_path
    else
      merchant.update(active: true)
      redirect_to admin_merchants_path
    end
  end

end
