require 'rails_helper'

RSpec.describe MovieData do
  it "can get movie data", :vcr do
    data = MovieData.all_movie_att('299536')
    expect(data.class).to eq(Hash)
    expect(data[:title]).to eq('Avengers: Infinity War')
  end
end