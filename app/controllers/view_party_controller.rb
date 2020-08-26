class ViewPartyController < ApplicationController
  before_action :require_user
  def new
    movie = SearchResults.new
    @movie = movie.movie_details(params[:q])
  end

  def create
    movie = Movie.create(name: params[:movie_name], duration: params[:duration], api_id: params[:movie_id])
    party = ViewParty.create(duration: params[:duration], date: params[:date], host: current_user, movie: movie)
    friends = []
    params[:friend_ids].values.flatten.each do |id|
      if id.empty? == false
        friend = User.find(id)
        ViewPartyAttendee.create(user: friend, view_party: party)
      end
    end

    redirect_to '/dashboard'
    flash[:message] = 'You have created a new Viewing Party!'
  end
end
