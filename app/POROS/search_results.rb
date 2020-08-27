class SearchResults
  def first_40_movie_results(search_query)
    movies = service.search_results(search_query)[:results].map do |movie_data|
      movie_result(movie_data)
    end
    movies.first(40)
  end

  def first_40_top_rated_movies
    movies = service.top_rated_movies[:results].map do |movie_data|
      movie_result(movie_data)
    end
    movies.first(40)
  end

  def movie_details(movie_id)
    movie_result(service.movie_data(movie_id))
  end

  def cast(movie_id)
  service.cast(movie_id)
  end

  def reviews(movie_id)
  service.reviews(movie_id)
  end

  private

  def service
    MovieService.new
  end

  def movie_result(data)
    MovieResult.new(data)
  end
end
