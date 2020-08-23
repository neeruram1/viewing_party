class ViewPartyController < ApplicationController
  def new
    movie = SearchResults.new
    @movie = movie.movie_details(params[:q])
  end

  def create
    movie = Movie.create(movie_params)
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

  private

  def movie_params
    params.permit(params[:movie_name], params[:duration], params[:movie_id])
  end
end
