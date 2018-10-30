class Merchant::OrdersController < Merchant::BaseController

  def index
    @merc = User.find(current_user.id)
    @orders = @merc.merchant_orders.uniq
  end
end
