require 'rails_helper'

RSpec.describe 'movie show page' do
  it "Should have all the details for the movie", :vcr do
    id = 299536
    search = SearchResults.new
    movie = search.movie_details(id)
    cast = search.cast(id)
    reviews = search.reviews(id)

    visit "/movies/#{id}"

    expect(page).to have_content(movie.vote_average)
    expect(page).to have_content(movie.runtime)
    expect(page).to have_content(movie.genres_names.first)
    expect(page).to have_content(movie.top_cast.first[:name])
    expect(page).to have_content(movie.top_cast.first[:character])
    expect(page).to have_content(movie.reviews_count)
    expect(page).to have_content(movie.reviews.first[:author])
    expect(page).to have_content("It is a bold undertaking, to readjust what is expected of the MCU/Avengers formula,")
  end
end
