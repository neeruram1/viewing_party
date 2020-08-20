require 'rails_helper'

RSpec.describe MovieData do
  it "should get all movies", :vcr do
    x = MovieData.movie_details('299536')
    y = MovieData.movie_reviews('299536')
    binding.pry
  end
end