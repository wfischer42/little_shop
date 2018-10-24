class UsersController < ApplicationController

  def new

  end

  def profile
    @user = User.find(current_user.id)
  end
end
