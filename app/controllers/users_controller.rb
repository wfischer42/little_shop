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
    if current_admin?
      @top_3_states = OrderItem.top_states
      @top_3_cities = OrderItem.top_cities
      @biggest_spenders = User.biggest_spenders
      @largest_orders = Order.highest_order_quantities
      @top_selling_merchants = User.top_selling_merchants
    elsif current_merchant?
      @total_sold = current_user.total_items_sold
      denom = (@total_sold + current_user.total_inventory)
      if denom > 0
        @pct_inventory = (@total_sold.to_f * 100) / denom
      else
        @pct_inventory = 0
      end
      @top_states = current_user.top_states
      @top_cities = current_user.top_cities
      @top_customers = current_user.top_customers
      @most_active_customer = current_user.most_active_customer || "No customers yet!"
      if largest_order = current_user.largest_order
        @largest_order = largest_order.id
      else
        @largest_order = "No orders yet!"
      end
    else

    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :address, :city, :state, :zip_code, :email, :password, :password_confirmation)
    end

end
