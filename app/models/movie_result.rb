class MovieResult
  attr_reader :title, :genres, :runtime, :summary, :cast, :reviews, :vote_average
  def initialize(data)
    @title = data[:title]
    @genres = data[:genres]
    @runtime = data[:runtime]
    @summary = data[:summary]
    @cast = data[:cast]
    @reviews = data[:reviews]
    @vote_average = data[:vote_average]
  end
  def top_cast
    top_10_cast = {}
    @cast.first(10).each do |cast_member|
      top_10_cast[cast_member[:name]] = cast_member[:character]
    end
    top_10_cast
  end

  def reviews_count
    @reviews.size
  end
end