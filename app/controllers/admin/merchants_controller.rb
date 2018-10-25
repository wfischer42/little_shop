class Admin::MerchantsController < ApplicationController
  # before_action :require_admin

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

  private
    def require_admin
      render file: "/public/404" unless current_admin?
    end

end
