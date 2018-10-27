class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :current_admin?
  helper_method :cart

  def current_user
    @user_lookup ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_admin?
    current_user && current_user.admin?
  end

  def cart
    @cart ||= Cart.new(session[:cart])
  end
end
