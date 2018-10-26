class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :current_admin?

  def current_user
    @user_lookup ||= User.find(session[:user_id])
  end

  def current_admin?
    current_user && current_user.admin?
  end

end
