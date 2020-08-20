require 'rails_helper'

RSpec.describe MovieResult do
  before :each do
    # data = File.open('/fixtures/movie_results.json', 'r')
    @data = MovieData.all_movie_att('299536')
    @result = MovieResult.new(@data)
  end
  it 'exists', :vcr do
    assert_instance_of MovieResult, @result
  end

  it 'has attributes', :vcr do
    expect(@result.title).to eq(@data[:title])
    expect(@result.genres).to eq(@data[:genres])
    expect(@result.runtime).to eq(@data[:runtime])
    expect(@result.summary).to eq(@data[:summary])
    expect(@result.cast).to eq(@data[:cast])
    expect(@result.reviews).to eq(@data[:reviews])
    expect(@result.vote_average).to eq(@data[:vote_average])
  end
end
