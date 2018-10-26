class Admin::MerchantsController < Admin::BaseController

  def show
    @merchant = User.find(params[:id])
  end

  def index
    @merchants = User.where(role: "merchant").order(:name)
  end

  def update
  end

end
