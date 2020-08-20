class MoviesController < ApplicationController
  def show
    @movie_result = MovieResult.new(MovieData.all_movie_att(params[:id]))
  end
end
