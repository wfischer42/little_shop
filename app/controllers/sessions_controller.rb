class SessionsController < ApplicationController

  def new

  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to (home_path(user))
    else
      flash.now[:notice] = "The email address or password you entered was incorrect"
      params[:password] = ""
      render :new
    end
  end

  private
    def home_path(user)
      return profile_path if user.customer?
      return dashboard_path if user.merchant? || user.admin?
    end
end
