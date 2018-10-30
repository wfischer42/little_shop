class Merchant::OrdersController < Merchant::BaseController

  def index
    @merc = User.find(current_user.id)
    @orders = Order.joins(:items).where("items.user_id = ?", @merc.id).uniq
  end
end
