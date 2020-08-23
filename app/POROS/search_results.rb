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
end
