class Admin::MerchantsController < Admin::BaseController

  def show
    @merchant = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    @url = admin_merchant_path(@user)
  end

  def update
    user = User.find(params[:id])
    if params[:attribute] == 'active'
      if user.active?
        user.update(active: false)
        flash[:notice] = "#{user.name} is now inactive."
        redirect_to controller: "/merchants", action: "index"
      else
        user.update(active: true)
        flash[:notice] = "#{user.name} is now active."
        redirect_to controller: "/merchants", action: "index"
      end
    elsif params[:attribute] == 'role'
      if user.customer?
        user.update(role: 1)
        flash[:notice] = "#{user.name} is now a merchant."
        redirect_to controller: "/merchants", action: "index"
      elsif user.merchant?
        user.update(role: 0)
        flash[:notice] = "#{user.name} is now a customer only."
        redirect_to controller: "/merchants", action: "index"
      end
    end
  end

end
