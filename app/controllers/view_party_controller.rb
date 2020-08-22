class ViewPartyController < ApplicationController
  def new
    @movie_result = MovieResult.new(MovieData.all_movie_att(params[:q]))
  end
end
