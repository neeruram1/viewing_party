class MoviesController < ApplicationController
  def index
    return @movie_results = MovieData.top_20_rated_movies if params[:q]
  end

  def show
    @movie_result = MovieResult.new(MovieData.all_movie_att(params[:id]))
  end
end
