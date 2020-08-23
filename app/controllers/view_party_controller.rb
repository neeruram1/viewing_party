class ViewPartyController < ApplicationController
  def new
    movie = SearchResults.new
    @movie = movie.movie_details(params[:q])
  end
end
