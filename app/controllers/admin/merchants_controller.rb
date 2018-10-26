class Admin::MerchantsController < Admin::BaseController

  def show
    @merchant = User.find(params[:id])
  end

  def update
    merchant = User.find(params[:id])
    if merchant.active?
      binding.pry

      merchant.update(active: false)
      binding.pry

      redirect_to merchants_path
    else
      binding.pry

      merchant.update(active: true)
      binding.pry

      redirect_to merchants_path
    end
  end

end
