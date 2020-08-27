class DiscoverController < ApplicationController
  before_action :require_user

  def index
    if params[:search].nil? == false || params[:q].nil? == false
      search_results = SearchResults.new
      if params[:search].nil? == false
        @movies = search_results.first_40_movie_results(params[:search])
      elsif params[:q].nil? == false
        @movies = search_results.first_40_top_rated_movies
      end
    end
  end
end
