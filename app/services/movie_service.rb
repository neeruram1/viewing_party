class MovieService
  def search_results(search_query)
    to_json("search/movie?query=#{search_query}")
  end

  def top_rated_movies
    to_json("movie/top_rated?")
  end

  def movie_data(movie_id)
    to_json("movie/#{movie_id}")
  end

  def cast(movie_id)
    to_json("movie/#{movie_id}/credits")
  end

  def reviews(movie_id)
    to_json("movie/#{movie_id}/reviews")
  end

private

    def conn
      Faraday.new('https://api.themoviedb.org/3/') do |f|
        f.params[:api_key] = ENV['MOVIE_API']
      end
    end

    def to_json(url)
      response = conn.get(url)
      JSON.parse(response.body, symbolize_names: true)
    end
  end
