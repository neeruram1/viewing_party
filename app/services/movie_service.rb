class MovieService
  def movies
    to_json('discover/movie')
  end

  def members(movie_id)
    to_json("/movie/#{movie_id}/credits")
  end

  def reviews(movie_id)
    to_json("/movie/#{movie_id}/reviews")
  end

  private

  def to_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new('https://api.themoviedb.org/3/') do |f|
      f.params[:api_key] = ENV['MOVIE_API']
    end
  end
end
