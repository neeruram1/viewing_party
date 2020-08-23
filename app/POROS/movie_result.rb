class MovieResult
  attr_reader :title,
              :vote_average,
              :runtime,
              :genres,
              :summary,
              :id

  def initialize(attributes)
    @title = attributes[:title]
    @vote_average = attributes[:vote_average]
    @runtime = attributes[:runtime]
    @genres = attributes[:genres]
    @summary = attributes[:summary]
    @id = attributes[:id]
  end

  def top_cast
    cast = SearchResults.new.cast(@id)
  end

  def genres_names
    genre_names = []
    @genres.each do |genre|
      genre_names << genre[:name]
    end
    genre_names
  end

  def reviews_count
    reviews.size
  end

  def reviews
    reviews = SearchResults.new.reviews(@id)
    reviews[:results]
  end
end
