class Admin::MerchantsController < Admin::BaseController

  def show
    @merchant = User.find(params[:id])
  end

  def update
    merchant = User.find(params[:id])
    if merchant.active?
      merchant.update(active: false)
      redirect_to controller: "/merchants", action: "index"
    else
      merchant.update(active: true)
      redirect_to controller: "/merchants", action: "index"
    end
  end

end
