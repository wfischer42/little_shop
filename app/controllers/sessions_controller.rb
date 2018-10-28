class SessionsController < ApplicationController

  def new
    if current_user
      flash[:notice] = "User is already logged in"
      redirect_to(profile_path)
    end
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password]) && user.active
      session[:user_id] = user.id
      flash[:notice] = "You have successfully logged in!"
      redirect_to (profile_path)
    else
      flash.now[:notice] = "The email address or password you entered was incorrect"
      render :new
    end
  end

  def destroy
    reset_session
    flash[:notice] = "You have been successfully logged out"
    redirect_to(root_path)
  end
end
