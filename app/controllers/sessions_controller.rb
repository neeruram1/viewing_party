class SessionsController < ApplicationController
  def create
    user = User.update_or_create(user_data)
    session[:user_id] = user.id
    redirect_to '/dashboard'
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = 'User Logged out successfully'

    redirect_to '/'
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end

  def user_data
    {
      uid: auth_hash['uid'],
      email: auth_hash['info']['email'],
      access_token: auth_hash['credentials']['token'],
      refresh_token: auth_hash['credentials']['refresh_token']
    }
  end
end
