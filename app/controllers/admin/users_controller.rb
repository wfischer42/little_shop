class Admin::UsersController < Admin::BaseController

  def edit
    @user = User.find(params[:id])
    @url = admin_user_path(@user)
  end

  def show
    @user = User.find(params[:id])
    @controller = 'admin/users'
    @path = admin_user_path(@user)
  end

  def index
    @users = User.where(role: 0)
    @controller = 'admin/users'
  end

  def update
    user = User.find(params[:id])
    if params[:attribute] == 'active'
      if user.active?
        user.update(active: false)
        flash[:notice] = "#{user.name} is now inactive."
        redirect_to admin_users_path
      else
        user.update(active: true)
        flash[:notice] = "#{user.name} is now active."
        redirect_to admin_users_path
      end
    elsif params[:attribute] == 'role'
        user.update(role: 1)
        flash[:notice] = "#{user.name} is now a merchant."
        redirect_to admin_merchant_path(user)
    else
      if user.update(user_params)
        flash[:success] = "User information Updated"
        redirect_to admin_user_path(user)
      else
        flash[:notice] = "Error"
        redirect_to admin_user_path(user)
      end
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :address, :city, :state, :zip_code, :email, :password, :password_confirmation)
    end
end
