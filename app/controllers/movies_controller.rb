class MoviesController < ApplicationController
  def index
    search = params[:search]
    url = "search/movie?query=#{params[:search]}"

    conn = Faraday.new('https://api.themoviedb.org/3/') do |f|
            f.params[:api_key] = ENV['MOVIE_API']
          end

    response = conn.get(url)
    json = JSON.parse(response.body, symbolize_names: true)

    @movies = json[:results].map do |movie_data|
      MovieResult.new(movie_data)
    end
  end

  def show
  end
end
