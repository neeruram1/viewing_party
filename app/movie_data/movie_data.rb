class MovieData
  def self.all_movie_att(movie_id)
    data = movie_details(movie_id)
    cast = movie_cast(movie_id)
    reviews = movie_reviews(movie_id)
    {
      summary: data[:overview],
      title: data[:title],
      runtime: data[:runtime],
      genres: data[:genres],
      reviews: reviews[:results],
      cast: cast[:cast],
      vote_average: data[:vote_average],
      id: data[:id]

    }
  end

  def self.movie_search_results(search_query)
    data = self.search(search_query)
    data[:results].first(40)
  end
  
  def self.top_20_rated_movies
    top_rated[:results].first(20)
  end
  
  private

  def self.all_movies
    MovieService.new.movies
  end

  def self.movie_details(movie_id)
    MovieService.new.movie_details(movie_id)
  end

  def self.movie_reviews(movie_id)
    MovieService.new.reviews(movie_id)
  end

  def self.movie_cast(movie_id)
    MovieService.new.cast(movie_id)
  end

  def self.search(search_query)
    MovieService.new.search(search_query)
  end

  def self.top_rated
    MovieService.new.toprated
  end
end
