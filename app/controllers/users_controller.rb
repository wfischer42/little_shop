class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Hello #{@user.name}"
      redirect_to profile_path
    else
      flash[:notice] = "Error"
      render :new
    end
  end

  def profile
    @user = User.find(current_user.id)
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(user_params)
      flash[:success] = "User information Updated"
      redirect_to profile_path
    elsif User.exists?(["email = ?", "#{params[:email]}"])
      flash[:notice] = "Email address is already in use"
      redirect_to profile_edit_path
    else
      flash[:notice] = "Error"
      redirect_to profile_edit_path
    end
  end

  def dashboard
    @user = User.find(current_user.id)
  end

  private

  def user_params
    params.require(:user).permit(:name, :address, :city, :state, :zip_code, :email, :password, :password_confirmation)
  end

end
