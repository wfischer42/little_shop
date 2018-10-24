class MerchantsController < ApplicationController

  def index
    @merchants = User.all.where(role: 1)
  end

end
