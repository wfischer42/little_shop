class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    @user_lookup ||= User.find(session[:user_id])
  end
<<<<<<< HEAD
=======

  def current_admin?
    current_user && current_user.admin?
  end
>>>>>>> end of day commit for this feature - feature is working, but need to check with team on routing and controller edits before continuing
end
