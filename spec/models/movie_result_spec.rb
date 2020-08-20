require 'rails_helper'

RSpec.describe MovieResult do
  before :each do
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

  it 'can list the first 10 cast members with their character', :vcr do
    cast = {"Robert Downey Jr."=>"Tony Stark / Iron Man",
            "Chris Hemsworth"=>"Thor Odinson",
            "Chris Evans"=>"Steve Rogers / Captain America",
            "Scarlett Johansson"=>"Natasha Romanoff / Black Widow",
            "Benedict Cumberbatch"=>"Stephen Strange / Doctor Strange",
            "Tom Holland"=>"Peter Parker / Spider-Man",
            "Chadwick Boseman"=>"T'Challa / Black Panther",
            "Don Cheadle"=>"James \"Rhodey\" Rhodes / War Machine",
            "Zoe Saldana"=>"Gamora",
            "Karen Gillan"=>"Nebula"}

    expect(@result.top_cast).to eq(cast)
  end

  it 'has total review count', :vcr do
    expect(@result.reviews_count).to eq(20)
  end
end
