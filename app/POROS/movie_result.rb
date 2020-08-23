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
end
