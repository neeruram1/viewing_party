class ViewPartyController < ApplicationController
  before_action :require_user
  def new
    movie_result = SearchResults.new
    movie = movie_result.movie_details(params[:q])
    @movie = Movie.create(name: movie.title, duration: movie.runtime, api_id: movie.id)
  end

  def create
    friends = params[:friend_ids].values.flatten

    if friends[1].nil?
      redirect_to new_view_party_path
      flash[:message] = "Please select a friend for this viewing party"
    else
      movie = Movie.find(params[:movie_id])
      party = ViewParty.create(duration: params[:duration], date: params[:date], host: current_user, movie: movie)

      friends.each do |id|
        if id.empty? == false
          friend = User.find(id)
          ViewPartyAttendee.create(user: friend, view_party: party)
        end
      end

      if party.save
        CalendarService.new.create_event(party.host, party)
        redirect_to '/dashboard'
        flash[:message] = 'You have created a new Viewing Party!'
      else
        redirect_to new_view_party_path
        flash[:message] = party.errors.full_messages.to_sentence
      end
    end
  end
end
