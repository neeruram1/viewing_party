class MovieData

  # private
  def self.all_movies
    MovieService.new.movies
  end

  def self.movie_details(movie_id)
    MovieService.new.members(movie_id)
  end

  def self.movie_reviews(movie_id)
    MovieService.new.reviews(movie_id)
  end
end
