class MovieService
  def search_results(search_query)
    url = "search/movie?query=#{search_query}"
    conn = Faraday.new('https://api.themoviedb.org/3/') do |f|
            f.params[:api_key] = ENV['MOVIE_API']
          end
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def top_rated_movies
    url = "movie/top_rated?"
    conn = Faraday.new('https://api.themoviedb.org/3/') do |f|
            f.params[:api_key] = ENV['MOVIE_API']
          end
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def movie_data(movie_id)
    url = "movie/#{movie_id}"
    conn = Faraday.new('https://api.themoviedb.org/3/') do |f|
            f.params[:api_key] = ENV['MOVIE_API']
          end
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def cast(movie_id)
    url = "movie/#{movie_id}/credits"
    conn = Faraday.new('https://api.themoviedb.org/3/') do |f|
            f.params[:api_key] = ENV['MOVIE_API']
          end
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def reviews(movie_id)
    url = "movie/#{movie_id}/reviews"
    conn = Faraday.new('https://api.themoviedb.org/3/') do |f|
            f.params[:api_key] = ENV['MOVIE_API']
          end
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end
