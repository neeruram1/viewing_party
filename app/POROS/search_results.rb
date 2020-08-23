class SearchResults
  def first_40_movie_results(search_query)
    json = MovieService.new.search_results(search_query)

    movies = json[:results].map do |movie_data|
      MovieResult.new(movie_data)
    end
    movies.first(40)
  end

  def first_40_top_rated_movies
    json = MovieService.new.top_rated_movies

    movies = json[:results].map do |movie_data|
      MovieResult.new(movie_data)
    end
    movies.first(40)
  end

  def movie_details(movie_id)
    json = MovieService.new.movie_data(movie_id)
    MovieResult.new(json)
  end

  def cast(movie_id)
    json = MovieService.new.cast(movie_id)
  end

  def reviews(movie_id)
    json = MovieService.new.reviews(movie_id)
  end
end
