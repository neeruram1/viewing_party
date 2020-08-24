class SearchResults
  def first_40_movie_results(search_query)
    json = service.search_results(search_query)

    movies = json[:results].map do |movie_data|
      movie_result(movie_data)
    end
    movies.first(40)
  end

  def first_40_top_rated_movies
    json = service.top_rated_movies

    movies = json[:results].map do |movie_data|
      movie_result(movie_data)
    end
    movies.first(40)
  end

  def movie_details(movie_id)
    json = service.movie_data(movie_id)
    movie_result(json)
  end

  def cast(movie_id)
    json = service.cast(movie_id)
  end

  def reviews(movie_id)
    json = service.reviews(movie_id)
  end

  private

  def service
    MovieService.new
  end

  def movie_result(data)
    MovieResult.new(data)
  end
end
