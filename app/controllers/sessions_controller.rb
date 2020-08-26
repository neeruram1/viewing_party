class SessionsController < ApplicationController
  def create
    user = User.update_or_create(user_data)
    session[:user_id] = user.id
    redirect_to '/dashboard'
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "User Logged out successfully"

    redirect_to '/'
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end

  def user_data
    {
      uid: auth_hash['uid'],
      name: auth_hash['info']['name'],
      email: auth_hash['info']['email']
    }
  end
end
