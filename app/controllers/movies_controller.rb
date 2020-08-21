class MoviesController < ApplicationController
  def index
    if params[:search].nil? == false
      @movie_results = MovieData.movie_search_results(params[:search])
    end
    return @movie_results = MovieData.top_20_rated_movies if params[:q]
  end

  def show
    @movie_result = MovieResult.new(MovieData.all_movie_att(params[:id]))
  end
end
