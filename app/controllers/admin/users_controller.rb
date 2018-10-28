class Admin::UsersController < Admin::BaseController

  def edit
    @user = User.find(params[:id])
    @url = admin_user_path(@user)
  end

  def show
    @user = current_user
    @controller = 'admin/users'
    @path = admin_user_path(@user)
  end

  def index
    @users = User.where(role: 0)
    @controller = 'admin/users'
  end

  def update
    user = User.find(params[:id])
    update_redirect = admin_user_path(user)
    if params[:attribute] == 'active'
      if user.active?
        user.update(active: false)
        flash[:notice] = "#{user.name} is now inactive."
        redirect_to controller: "admin/users", action: "index"
      else
        user.update(active: true)
        flash[:notice] = "#{user.name} is now active."
        redirect_to controller: "admin/users", action: "index"
      end
    elsif params[:attribute] == 'role'
      if user.customer?
        user.update(role: 1)
        flash[:notice] = "#{user.name} is now a merchant."
        redirect_to controller: "admin/users", action: "index"
      elsif user.merchant?
        user.update(role: 0)
        flash[:notice] = "#{user.name} is now a customer only."
        redirect_to controller: "admin/users", action: "index"
      end
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
