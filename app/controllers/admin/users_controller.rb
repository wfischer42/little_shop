class Admin::UsersController < Admin::BaseController

  def edit
    @user = User.find(params[:id])
    if @user.merchant?
      redirect_to admin_merchant_path(@user)
    elsif @user.customer?
      redirect_to admin_user_path(@user)
    end
  end
end
