class UsersController < ApplicationController

  def new
    @user = User.new
    @url = register_path
  end

  def create
    @user = User.create(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "You are now registered and logged in #{@user.name}"
      redirect_to profile_path
    elsif User.where.not(id: @user.id).exists?(email: user_params[:email])
      flash[:notice] = "Email address is already in use"
      render :new
    else
      flash[:notice] = "Error"
      render :new
    end
  end

  def profile
    @user = current_user
    @path = profile_path
  end

  def edit
    @user = current_user
    @url = profile_path
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:success] = "User information Updated"
      redirect_to profile_path
    elsif User.where.not(id: @user.id).exists?(email: user_params[:email])
      flash[:notice] = "Email address is already in use"
      redirect_to profile_edit_path
    else
      flash[:notice] = "Error"
      redirect_to profile_edit_path
    end
  end

  def dashboard
    @user = User.find(current_user.id)
    @order_is_empty = @user.merchant_orders.empty?
  end

  private
    def user_params
      params.require(:user).permit(:name, :address, :city, :state, :zip_code, :email, :password, :password_confirmation)
    end

end
