class MoviesController < ApplicationController
  before_action :require_user

  def index
    search_results = SearchResults.new
    if params[:search].nil? == false
      @movies = search_results.first_40_movie_results(params[:search])
    else params[:q].nil? == false
      @movies = search_results.first_40_top_rated_movies
    end
  end

  def show
    movie = SearchResults.new
    @movie = movie.movie_details(params[:id])
  end
end
