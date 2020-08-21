require 'rails_helper'

RSpec.describe MovieData do
  it "can get movie data", :vcr do
    data = MovieData.all_movie_att('299536')
    expect(data.class).to eq(Hash)
    expect(data[:title]).to eq('Avengers: Infinity War')
  end

  it 'can get top 20 rated', :vcr do
    data = MovieData.top_20_rated_movies
    expect(data.class).to eq(Array)
    expect(data.size).to eq(20)
    expect(data.first[:title]).to eq('Gabriel\'s Inferno Part II')
  end
end
