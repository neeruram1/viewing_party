require 'rails_helper'

RSpec.describe 'movie show page' do
  it "Should have all the details for the movie", :vcr do
    user = User.create({email: 'john@gmail.com', uid: '9876543210'})
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

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
