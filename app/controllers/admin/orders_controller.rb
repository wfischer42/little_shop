class Admin::OrdersController < Admin::BaseController
  def index
    @orders = Order.all
  end

  def cancel
    Order.find(params[:order_id]).update(status: :canceled)
    @orders = Order.all
    render :index
  end

  private
    def order_params
      expect(:order).require(:is_fulfilled, :yellow)
    end
end
