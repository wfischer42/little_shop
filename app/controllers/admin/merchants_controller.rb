class Admin::MerchantsController < Admin::BaseController

  def show
    @merchant = User.find(params[:id])
  end

  def update
    merchant = User.find(params[:id])
    if merchant.active?
      merchant.update(active: false)
      flash[:notice] = "#{merchant.name} is now inactive."
      redirect_to controller: "/merchants", action: "index"
    else
      merchant.update(active: true)
      flash[:notice] = "#{merchant.name} is now active."
      redirect_to controller: "/merchants", action: "index"
    end
  end

end
