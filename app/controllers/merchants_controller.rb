class MerchantsController < ApplicationController

  def index
    @merchants = User.where(role: "merchant").order(:name)
  end

end
