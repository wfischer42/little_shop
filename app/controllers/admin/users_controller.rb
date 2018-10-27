class Admin::UsersController < Admin::BaseController

  def edit
    @user = User.find(params[:id])
    @url = admin_user_path(@user)
  end

  def show
    @user = current_user
    @controller = 'admin/users'
  end
end
