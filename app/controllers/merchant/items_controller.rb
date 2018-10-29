class Merchant::ItemsController < Merchant::BaseController

  def index
    @users = User.where(role: 1)
    @controller = 'merchant/items'
  end

end
