class FriendshipController < ApplicationController
  def create
    user = User.find(current_user.id)
    friend = User.find_by(email: params[:email])
    friendship = Friendship.create(user: user, friend: friend)

    if friendship.save
      redirect_to '/dashboard'
      flash[:message] = 'Friend successfully added'
    else
      redirect_to '/dashboard'
      flash[:error] = friendship.errors.full_messages.to_sentence
    end
  end

  private

  def friendship_params
    params.permit(:email)
  end
end
