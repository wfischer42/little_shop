class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Hello #{@user.name}"
      redirect_to root_path
    else
      flash[:notice] = "Error"
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :address, :city, :state, :zip_code, :email, :password, :password_confirmation)
  end
end
