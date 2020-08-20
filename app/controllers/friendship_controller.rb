class FriendshipController < ApplicationController
  def create
    user = User.find(current_user.id)
    friend = User.find_by(email: params[:email])
    Friendship.create(user: user, friend: friend)
    redirect_to '/dashboard'
  end

  private

  def friendship_params
    params.permit(:email)
  end
end
