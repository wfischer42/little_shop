class MerchantsController < ApplicationController

  def index
    @users = User.where(role: "merchant").order(:name)
    @controller = 'admin/merchants'
  end
end
