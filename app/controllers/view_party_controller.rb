class ViewPartyController < ApplicationController
  before_action :require_user
  def new
    movie_result = SearchResults.new
    movie = movie_result.movie_details(params[:q])
    @movie = Movie.create(name: movie.title, duration: movie.runtime, api_id: movie.id)
  end

  def create
    movie = Movie.find(params[:movie_id])
    party = ViewParty.create(duration: params[:duration], date: params[:date], host: current_user, movie: movie)
    params[:friend_ids].values.flatten.each do |id|
      if id.empty? == false
        friend = User.find(id)
        ViewPartyAttendee.create(user: friend, view_party: party)
      end
    end

    CalendarService.new.create_event(party.host, party)

    redirect_to '/dashboard'
    flash[:message] = 'You have created a new Viewing Party!'
  end
end
