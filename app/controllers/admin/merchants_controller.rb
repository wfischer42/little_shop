class Admin::MerchantsController < Admin::BaseController

  def show
    @user = User.find(params[:id])
    @controller = 'admin/merchants'
    @path = admin_merchant_path(@user)
  end

  def edit
    @user = User.find(params[:id])
    @url = admin_merchant_path(@user)
  end

  def update
    user = User.find(params[:id])
    update_redirect = admin_merchant_path(user)
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
        user.update(role: 0)
        flash[:notice] = "#{user.name} is now a customer only."
        redirect_to controller: "admin/users", action: "show"
    else
      if user.update(user_params)
        flash[:success] = "User information Updated"
      redirect_to update_redirect
      else
        flash[:notice] = "Error"
        redirect_to update_redirect
      end
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :address, :city, :state, :zip_code, :email, :password, :password_confirmation)
    end

end
