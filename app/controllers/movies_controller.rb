class MoviesController < ApplicationController
  def index

  end
  
  def show
    @movie_result = MovieResult.new(MovieData.all_movie_att(params[:id]))
  end
end
