class Admin::MerchantsController < Admin::BaseController

  def show
    @merchant = User.find(params[:id])
  end

  def index
    @merchants = User.where(role: "merchant").order(:name)
  end

  def update
    @merchant = User.find(params[:id])
    redirect_to admin_merchants_path
  end

end
