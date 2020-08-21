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
      vote_average: data[:vote_average]

    }
  end

  def self.top_20_rated_movies
    top_rated[:results].first(20)
  end

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

  def self.top_rated
    MovieService.new.toprated
  end
end
