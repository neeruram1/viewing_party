require 'rails_helper'

describe MovieResult do
  it "exists" do
    attrs = {
          :title => "Return of the Jedi",
          :vote_average => "10",
          :runtime => "145",
          :genres => (["Drama", "Science Fiction"]),
          :summary => "An execellent film",
          :id => 145
    }

    movie = MovieResult.new(attrs)

    expect(movie).to be_a MovieResult
    expect(movie.title).to eq("Return of the Jedi")
    expect(movie.vote_average).to eq("10")
    expect(movie.runtime).to eq("145")
    expect(movie.genres).to eq(["Drama", "Science Fiction"])
    expect(movie.summary).to eq("An execellent film")
    expect(movie.id).to eq(145)
  end
end
