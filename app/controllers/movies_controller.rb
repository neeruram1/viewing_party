class MoviesController < ApplicationController
  before_action :require_user

  def show
    movie = SearchResults.new
    @movie = movie.movie_details(params[:id])
  end
end
